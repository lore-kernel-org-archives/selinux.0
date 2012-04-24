Subject: Re: Success - SEAndroid on Galaxy Nexus maguro
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Palarz Thomas-DCJ738 <tom.palarz@motorolasolutions.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
In-Reply-To: <535CAAB8CFB77F45B4140FC615F0F21E07804B21@CH1PRD0410MB381.namprd04.prod.outlook.com>
References: 
	 <535CAAB8CFB77F45B4140FC615F0F21E07804B21@CH1PRD0410MB381.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Apr 2012 10:48:14 -0400
Message-ID: <1335278894.32733.66.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-04-24 at 14:13 +0000, Palarz Thomas-DCJ738 wrote:
> All,
> 
> I've gotten SEAndroid 4.0.3 running on a Samsung Galaxy Nexus maguro
> (GSM). I've seen posts about it running on Galaxy Nexus already, but I
> assume that was the CDMA version toro. Thought I'd my 2 cents and get
> it going on the GSM handset.
> 
> I did have to manually(-ish) build the zImage in order for mkbootimg
> build dependency to be satisfied and didn't see that on the wiki.
> What's the reasoning for creating a separate project for the omap tuna
> kernel btw? I assume it's because the Android build system is using a
> prebuilt kernel for the recovery image and we wanted an SELinux-aware
> kernel in place of it?

Correct.  We have a slightly modified kernel/omap tree that enables
SELinux and its dependencies in the kernel config and adds SELinux
permission checking for the Binder.  Then we have a slightly modified
device/samsung/tuna tree that uses our kernel rather than the prebuilt
one, defines HAVE_SELINUX := true in the BoardConfig.mk for the
userspace build, modifies init.tuna.rc, and adds the sepolicy.* files
for the tuna-specific policy definitions.

> I haven't successfully turned enforcing on yet, but I have some avc
> denials. I'll try to run audit2allow tonight. The new SEAndroid
> Manager app with the avc log file save capability is really nifty ;)

You might want to post the denials first for review.  Often the
audit2allow output is not what you want; instead you may simply need to
label some files correctly to get everything working cleanly.

> Has anyone been trying to get SLIDE/CDS working with the SEAndroid
> policy? My last attempt at it didn't work out because the SEAndroid
> policy isn't being compiled in the Referency Policy format as far as I
> can tell, but I haven't spent significant amounts of time on it either
> to be honest.

I briefly experimented with SLIDE as well (as you note, it doesn't work
presently) and have asked the SLIDE developers for more information
about its specific dependencies on refpolicy.  I suspect we would at
least need to introduce the same kind of inline xml documentation for
our macros so that they can be recognized by SLIDE, and we might have to
follow refpolicy's directory layout and naming conventions if we want
SLIDE to work seamlessly.  Might also need some equivalents to
refpolicy's build.conf and modules.conf files.  

I'm not sure though how critical it is, as the SE Android policy is
quite small and simple so it isn't clear how much you would gain from an
IDE.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
