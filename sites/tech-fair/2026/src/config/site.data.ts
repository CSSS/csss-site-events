import type { NavItem, SiteConfig } from '@csss-site-events/ui/types';

export interface TechFair2026SiteConfig extends SiteConfig {
  eventDate: string;
}

export const navItems: NavItem[] = [
  {
    label: 'About',
    href: '#about'
  },
  {
    label: 'Students',
    href: '#students'
  },
  {
    label: 'Companies',
    href: '#companies'
  },
  {
    label: 'Sponsors',
    href: '#sponsors'
  }
];

export const siteConfig: TechFair2026SiteConfig = {
  name: 'Tech Fair 2026',
  title: 'Tech Fair',
  description: 'Description',
  eventName: 'Tech Fair 2026',
  eventDate: 'November 4'
};

export const variantOrder = ['red', 'blue', 'pink', 'teal'] as const;
