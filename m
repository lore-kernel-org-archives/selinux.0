Subject: Re: You mentioned somewhere there is a step by step guide
	to	getting the MLS policy installed on a machine?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <424175DA.9040804@redhat.com>
References: <41EC4682.8050807@trustedcs.com>
	 <41F6D30D.9070904@trustedcs.com>
	 <1106771757.23386.348.camel@moss-spartans.epoch.ncsc.mil>
	 <42408CAB.4030007@redhat.com>
	 <1111583468.21107.15.camel@moss-spartans.epoch.ncsc.mil>
	 <424175DA.9040804@redhat.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 09:03:35 -0500
Message-Id: <1111586615.21107.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-03-23 at 08:57 -0500, Daniel J Walsh wrote:
> If I follow those instructions with the Current Rawhide kernel and the 
> soon to be released selinux-policy-mls, can I get a SELinux/MLS machine
> up and running or do I need addtional packages from TCS?

You should be able to get a basic system working without any further
packages (I did).  But you will need to make the home directory and /tmp
ranged (as mentioned in README.MLS) in order to allow access by multiple
levels since the polyinstantiated directory support is not in the
mainline kernel, and are likely to encounter various denials when trying
to operate at multiple levels.  For a fully operational MLS system,
there will have to be further userspace work.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
