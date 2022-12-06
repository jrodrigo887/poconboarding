class SelectOption {
  final String label;
  final String value;

  SelectOption({required this.label, required this.value});
}

final List<SelectOption> ambients = [
  SelectOption(
      label: 'Prod', value: 'https://app.certfy.tech/onboarding/autoid/'),
  SelectOption(
      label: 'Dev', value: 'https://app-dev.certfy.tech/onboarding/autoid/'),
  SelectOption(
      label: 'Test', value: 'https://app-test.certfy.tech/onboarding/autoid/'),
  SelectOption(
      label: 'Homol', value: 'https://app-hmlg.certfy.tech/onboarding/autoid/'),
  SelectOption(
      label: 'locahost',
      value: 'http://192.168.100.41:8082/onboarding/autoid/'),
  SelectOption(
      label: 'Dev Widget',
      value:
          'https://app-dev.certfy.tech/onboarding/app/queue/94612025-d6f5-4951-91f0-118016d92944'),
  SelectOption(
      label: 'localhost Widget',
      value:
          'http://192.168.100.41:8082/onboarding/app/queue/94612025-d6f5-4951-91f0-118016d92944'),
  SelectOption(
      label: 'Prefeitura',
      value:
          'https://app.certfy.tech/onboarding/autoid/4dfdc18d-79cd-47e6-9b36-92592b0af9ce')
];

final List<SelectOption> topics = [
  SelectOption(label: 'AutoId Prod', value: ''),
  SelectOption(
      label: 'AutoId Dev1', value: 'c873938a-7c34-43a8-9218-66f6b45e3066'),
  SelectOption(
      label: 'AutoId Dev2', value: '3e0ecdce-eb90-4e52-a50b-9883974b859c'),
  SelectOption(
      label: 'AutoId Test', value: 'c2e8f18b-ea7d-4d85-96b4-e3a8906d4a9a'),
  SelectOption(label: 'AutoId Homol', value: ''),
];
