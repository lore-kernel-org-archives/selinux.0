Subject: Re: [RFC PATCH 2/3] libselinux: define the "context" security class
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Christopher PeBenito <cpebenito@tresys.com>
In-Reply-To: <452549BF.6000302@trustedcs.com>
References: <452549BF.6000302@trustedcs.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 14:46:48 -0400
Message-Id: <1160074008.2132.169.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-05 at 13:06 -0500, Darrel Goeddel wrote:
> Define a new security class "context" and its permission "translate" for
> use by the context translation daemon.  The files are generated from the
> current reference policy and have been altered by "make indent".  Note
> the change in blank lines in av_permissions.h - should libselinux change,
> should the script in the policy change, or should there be a manual
> conversion?  The "polmatch" perm on the association class was also pulled
> in from the policy.

And setsockcreate removed, because refpolicy still doesn't have it.  Can
someone add it, please?

I think the divergence in blank lines is due to a change in the script
(to avoid extraneous lines in the kernel headers), so we can just resync
libselinux to the generated one.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
