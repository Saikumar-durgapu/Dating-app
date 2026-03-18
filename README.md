# Spark iOS Dating App (MVP)

Spark is a production-minded iOS dating app MVP built with **SwiftUI + MVVM + async/await** and a scalable service/repository architecture.

## 1) Product overview
Spark helps users sign up, build profiles, discover nearby people, like/pass cards, create mutual matches, and chat in 1:1 conversations.

## 2) Feature list (MVP + placeholders)
- Onboarding: splash, intro, login/sign up, forgot password, terms acceptance.
- Profile setup: demographics, bio, interests, city, photos, completion progress.
- Discover: swipe-style card stack, like/pass, empty state, match modal.
- Matching: mutual-like detection and match persistence.
- Chat: match inbox + text messages.
- Profile: view/edit/preview.
- Settings/safety: logout, delete placeholder, report/block structures, safety tips.
- Premium placeholders: boosts, read receipts, advanced filters.

## 3) Architecture decision
- **Pattern:** MVVM + Protocol-first services + repositories.
- **Reasoning:** fast MVP with clean boundaries for backend swap and feature scaling.
- **Backend choice for speed:** **Supabase** (Postgres schema + RLS + storage + auth) is recommended for startup velocity and safer query evolution than document-only structures.
- **Current build mode:** mock-first services compile/run without backend credentials.

## 4) Folder structure
```
Spark/
  App/
  Core/
  Models/
  Services/
    Mock/
  Repositories/
  ViewModels/
  Views/
    Onboarding/ Auth/ ProfileSetup/ Discover/ Matches/ Chat/ Profile/ Settings/ Placeholders/
  Components/
  Resources/
  Utilities/
```

## 5) Data models
Codable models included:
- User
- UserProfile
- ProfilePhoto
- Interest
- Like
- Match
- Conversation
- Message
- Report
- BlockedUser
- AppSettings

## 6) Backend schema (Supabase recommendation)
- `users` (auth uid, email, created_at)
- `profiles` (user_id PK/FK, first_name, dob, gender, interested_in[], bio, occupation, height_cm, city, location geography, hide_age, hide_distance, updated_at)
- `profile_photos` (id, user_id, storage_path, order_index, created_at)
- `interests` (id, name)
- `profile_interests` (profile_id, interest_id)
- `likes` (id, from_user_id, to_user_id, created_at, unique(from_user_id,to_user_id))
- `passes` (id, from_user_id, to_user_id, created_at, unique(from_user_id,to_user_id))
- `matches` (id, user_a, user_b, created_at, unique(least(user_a,user_b), greatest(user_a,user_b)))
- `conversations` (id, match_id, updated_at)
- `messages` (id, conversation_id, sender_id, recipient_id, message_type, content, media_url, sent_at, read_at)
- `reports` (id, reporter_id, reported_user_id, reason, description, created_at, status)
- `blocked_users` (id, user_id, blocked_user_id, created_at, unique(user_id, blocked_user_id))
- `app_settings` (user_id PK, notifications_enabled, show_distance, show_age, theme)

RLS ideas:
- Users can read/write only their own profile/settings.
- Messages readable only by conversation participants.
- Insert likes only when `auth.uid() = from_user_id`.
- Deny discovery rows where block relation exists.

Storage bucket:
- `profile-photos` private bucket with signed URL generation.

## 7) Navigation map
- Root: Splash → Onboarding → Auth → Profile Setup (if incomplete) → Main tabs.
- Tabs: Discover / Matches / Profile / Settings.
- Secondary: Forgot password, edit profile, photo upload, chat, safety center, report, premium.

## 8) Reusable components
- SparkButton
- SparkTextField
- ProfileCardView
- LoadingStateView
- EmptyStateView
- Design tokens (colors, spacing, gradients)

## 9) Screen implementations
Implemented SwiftUI screens:
- SplashView
- OnboardingView
- LoginView
- SignUpView
- ForgotPasswordView
- ProfileSetupView
- PhotoUploadView
- DiscoverView
- MatchPopupView
- MatchesListView
- ChatView
- ProfileView
- EditProfileView
- SettingsView
- SafetyCenterView
- ReportUserView
- PremiumPlaceholderView

## 10) Services/repositories
Services via protocols:
- AuthServiceProtocol
- ProfileServiceProtocol
- DiscoveryServiceProtocol
- MatchServiceProtocol
- ChatServiceProtocol
- SafetyServiceProtocol

Mock implementations for all services + `ServiceContainer`.
Repositories:
- UserRepository
- MatchRepository

## 11) View models
- AuthViewModel
- ProfileSetupViewModel
- DiscoverViewModel
- MatchesViewModel
- ChatViewModel

## 12) Mock data
`SampleData.swift` includes users, interests, match, conversation, and starter messages.

## 13) Testing strategy
- Unit test service logic with mock store actor.
- Unit test discovery filters: self/block/pass/match exclusions.
- Unit test match dedupe and mutual-like creation.
- Snapshot/UI tests for key screens in light/dark mode.
- Integration tests for auth/profile/messaging async flows.

## 14) Next steps to run locally
1. Create an iOS App target in Xcode named `Spark`.
2. Add all `Spark/` files into target membership.
3. Set deployment target to latest stable iOS.
4. Run app (mock mode works without backend).
5. Replace mock services with Supabase adapters and env-based config.

## Security and privacy notes
- Keep API keys in xcconfig/secrets manager, never hardcode.
- Validate auth state at app launch and sensitive actions.
- Use signed URLs/private storage for profile images.
- Audit/block/report tables enable moderation pipelines.
- Expand with server-side content moderation and abuse detection.
