import type { NavItem, SiteConfig } from '@csss-site-events/ui/types';

export interface Frosh2026SiteConfig extends SiteConfig {
  startDate: string;
  endDate: string;
}

export const navItems: NavItem[] = [
  {
    label: 'About',
    href: '#about'
  },
  {
    label: 'Schedule',
    href: '#schedule'
  },
  {
    label: 'Sponsors',
    href: '#sponsors'
  },
  {
    label: 'FAQ',
    href: '#faq'
  }
];

export const siteConfig: Frosh2026SiteConfig = {
  name: 'Frosh 2026',
  title: 'Frosh 2026',
  description: "Frosh Week 2026 hosted by SFU's Computing Science Student Society",
  eventName: 'Once Upon a Frosh',
  startDate: 'September 14',
  endDate: 'September 19'
};
