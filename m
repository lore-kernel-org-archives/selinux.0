Subject: [RFC] sectioned package format
From: Joshua Brindle <jbrindle@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 14:59:41 -0400
Message-Id: <1129748381.15338.20.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1. Introduction

This is our proposal for sectioned package formats, it addresses the 
issues brought up on the fedora-selinux list and the selinux list. It
allows for forward/backward compatibility by being able to skip unknown 
sections. It also allows for 'fat' packages, which may contain modules 
for multiple distributions, targeted/strict/MLS, and so on within the 
same package. We believe this format is extensible and fairly future
proof, please give us feedback so that we can start implementing this.

The policy package is designed similarly to the ELF file format.
The package consists of a package header, section header, and section
data.  Other than the package header, all others may appear in any
order within the file.


2. Policy Package Header

The first 32 bytes of a policy package consists of its header:

  uint32_t magic_number;
  char package_string[16];
  uint32_t package_file_version;
  uint32_t section_offset;
  uint32_t num_sections;

where uint32_t is a 4-byte datum stored in little-endian format.  The
magic_number identifies this file as a loadable policy package; that
value is 0xf97c668f.

package_string is a string constant, padded with '\0' bytes at the end
if the string is not 16 characters.  At present the package_string is
"SE Linux Package".  Observe that there is no terminating '\0' here.

package_file_version identifies which version of policy package this
file is using.  The only supported version currently is 1.

section_offset gives the file offset to the section header table,
which is described next.  This value is in terms of bytes and is
relative to the beginning of the file.  num_sections gives the total
number of sections in this file.


3. Section Header Table

Each entry within the section header table consists of:

  uint32_t name_length;
  uint32_t offset;
  uint32_t size;
  uint32_t key;
  uint32_t section_info[3];
  char *section_name;

Each sction has a name, and there may be more than one section witht he 
same name. Although not enforced by the policy package format, certain 
names have specific meanings by convention.  Section 4 describes those 
special sections.  The name is stored within the section header table, 
unlike the ELF format, at the end of each record.  name_length is the 
number of characters in the section name, including the terminating 
'\0'.  Section names can be any length, though for brevity they should 
be kept under 32 characters.

The offset gives the location for that section's data.  It is
in terms of bytes from the beginning of the file.  The number of bytes
for the section is kept in the size field.

Often sections are interrelated.  The next 4 bytes, key, is a way to
indicate relationships.  All sections with the same key value are to
be handled together.  Exactly how is dependent upon the kinds of
sections involved; for example, a module and file_contexts section will
be related by having the same key. This is how a particular
file_contexts section is associated with it's module in a package with
multiple modules.

The next 12 bytes of the section header record is reserved for that
section's use.  For sections that do not need it they should be filled
with zeroes.


4. Kinds of Sections

The following table lists common section types.  Recall that they
may appear in any order within the file.  The policy package reader is
to ignore unknown section names.

section "module":

This section contains a loadable module policy.  The first 4 bytes of
its section_info field gives the policy kind; it is a series of bits
logically or'ed together. For example:

  section_info[0] := bitfield of
    0x01 = targeted
    0x02 = strict
    0x04 = MLS
    0x08 = MCS

The next 4 bytes indicate for which Linux distributions this policy is
meant. For example:

  section_info[1] := bitfield of
    0x01 = Red Hat / Fedora Core
    0x02 = Gentoo
    0x04 = Debian GNU/Linux

The last 4 bytes gives the module format version.  At this time only
version 5 is accepted.
  section_info[2] := 5

For example, a module written for FC5, strict, and MCS would be:
  section_info[3] := {0x0a, 0x01, 0x05}

section "file contexts":

Listed here are a series of name-value pairs of filename regular
expressions and their comments.  The contents are the same as that of
/etc/selinux/strict/contexts/files/file_contexts.  There may be
multiple file contexts stored within the package.  To determine which
one to use select the appropriate module section, then select the file
contexts that shares the same key value.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
