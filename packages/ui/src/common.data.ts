export const socialLinks: Record<string, string> = {
  website: 'https://sfucsss.org',
  discord: 'https://discord.gg/sfucsss',
  instagram: 'https://www.instagram.com/sfu_csss/',
  linkedin: 'https://ca.linkedin.com/company/sfucsss',
  facebook: 'https://www.facebook.com/sfucsss'
};

export const brandColours = ['red', 'blue', 'pink', 'teal'] as const;

export function getBrandColour(index: number) {
  return brandColours[index % brandColours.length];
}
