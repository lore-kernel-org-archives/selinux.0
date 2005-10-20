Subject: Re: [RFC] sectioned package format
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux-dev@tresys.com, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>, Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1129748381.15338.20.camel@twoface.columbia.tresys.com>
References: <1129748381.15338.20.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 08:26:14 -0400
Message-Id: <1129811174.2375.333.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 14:59 -0400, Joshua Brindle wrote:
> This is our proposal for sectioned package formats, it addresses the 
> issues brought up on the fedora-selinux list and the selinux list. It
> allows for forward/backward compatibility by being able to skip unknown 
> sections. It also allows for 'fat' packages, which may contain modules 
> for multiple distributions, targeted/strict/MLS, and so on within the 
> same package. We believe this format is extensible and fairly future
> proof, please give us feedback so that we can start implementing this.

Do we think that these "fat" module packages will actually be used in
practice, or that people will just build separate module packages for
the variants?   BTW, possible point of confusion due to overloaded
terminology:  "module package" is not related to a traditional Linux
"package" (i.e. something managed by rpm or dpkg), so a traditional
"package" could contain multiple "module packages".

> This section contains a loadable module policy.  The first 4 bytes of
> its section_info field gives the policy kind; it is a series of bits
> logically or'ed together. For example:
> 
>   section_info[0] := bitfield of
>     0x01 = targeted
>     0x02 = strict
>     0x04 = MLS
>     0x08 = MCS
> 
> The next 4 bytes indicate for which Linux distributions this policy is
> meant. For example:
> 
>   section_info[1] := bitfield of
>     0x01 = Red Hat / Fedora Core
>     0x02 = Gentoo
>     0x04 = Debian GNU/Linux

Not sure that we want this kind of information stored in the policy
module packages themselves, again going back to the question of whether
"fat" module packages are useful versus separate module packages.  What
is going to interpret and use this information?

> section "file contexts":
> 
> Listed here are a series of name-value pairs of filename regular
> expressions and their comments.  The contents are the same as that of
> /etc/selinux/strict/contexts/files/file_contexts.

name-value pairs?  So semodule_package(1) (or
sepol_module_package_set_file_contexts(3)) has to parse and convert a
native file_contexts configuration file to a name-value pair
specification rather than just treating it as a byte stream?  And the
reverse translation has to be done when extracting it from the package? 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
