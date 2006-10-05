Message-ID: <45255DE6.1090608@trustedcs.com>
Date: Thu, 05 Oct 2006 14:32:54 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: Re: [RFC PATCH 2/3] libselinux: define the "context" security class
References: <452549BF.6000302@trustedcs.com> <1160074008.2132.169.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160074008.2132.169.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-10-05 at 13:06 -0500, Darrel Goeddel wrote:
> 
>>Define a new security class "context" and its permission "translate" for
>>use by the context translation daemon.  The files are generated from the
>>current reference policy and have been altered by "make indent".  Note
>>the change in blank lines in av_permissions.h - should libselinux change,
>>should the script in the policy change, or should there be a manual
>>conversion?  The "polmatch" perm on the association class was also pulled
>>in from the policy.
> 
> 
> And setsockcreate removed, because refpolicy still doesn't have it.  Can
> someone add it, please?

D'oh,  I'll make sure that I don't remove that in a final patch.

> I think the divergence in blank lines is due to a change in the script
> (to avoid extraneous lines in the kernel headers), so we can just resync
> libselinux to the generated one.

Sounds good.  I think we should also modify the scripts in the policy to
generate the files in the style of "make indent".  Not terribly important
considering the easiness of make indent and the frequency of changes like
this.

I'll generate a kernel patch as well if this all flies.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
