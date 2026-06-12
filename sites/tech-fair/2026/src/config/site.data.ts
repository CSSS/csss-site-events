import type { NavItem, SiteConfig } from '@csss-site-events/ui/types';

export interface TechFair2026SiteConfig extends SiteConfig {
  eventDate: string;
}
export const navItems: NavItem[] = [
  {
    label: 'Link',
    href: '/tech-fair/2026'
  },
  {
    label: 'Link',
    children: [
      {
        label: 'Link 1',
        href: 'link/to/1'
      }
    ]
  },
  {
    label: 'Link',
    children: [
      {
        label: 'Link 1',
        href: 'link/to/1'
      }
    ]
  },
  {
    label: 'Link',
    href: '/tech-fair/2026'
  },
  {
    label: 'Link',
    children: [
      {
        label: 'Link 1',
        href: 'link/to/1'
      }
    ]
  }
];

export const siteConfig: TechFair2026SiteConfig = {
  name: 'Tech Fair 2026',
  title: 'Tech Fair',
  description: 'Description',
  eventName: 'Tech Fair 2026',
  eventDate: 'November 4'
};
