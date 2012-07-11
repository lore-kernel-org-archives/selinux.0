Message-ID: <1342010287.29461.16.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Anon_inodefs denials in SEAndroid with genlock
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Palarz Thomas-DCJ738 <tom.palarz@motorolasolutions.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Wed, 11 Jul 2012 08:38:07 -0400
In-Reply-To: <535CAAB8CFB77F45B4140FC615F0F21E1D2ADA2B@CH1PRD0410MB381.namprd04.prod.outlook.com>
References: 
	<535CAAB8CFB77F45B4140FC615F0F21E1D2AD9EC@CH1PRD0410MB381.namprd04.prod.outlook.com>
	 <1341937629.16964.57.camel@moss-pluto.epoch.ncsc.mil>
	 ,<1341938716.16964.61.camel@moss-pluto.epoch.ncsc.mil>
	 <535CAAB8CFB77F45B4140FC615F0F21E1D2ADA2B@CH1PRD0410MB381.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-10 at 20:57 +0000, Palarz Thomas-DCJ738 wrote:
> I'm still confused on the MLS constraint. There are no objects being
> labeled with a category as far as I can tell (sensitivity only) and
> surfaceflinger is an mlstrustedsubject (which I thought would let it
> write down and was the way for it to bypass the stringent and
> impractical vanilla BLP).

But the denials you were showing were between trusted_app and
genlock_device or trusted_app and unlabeled.  So you'd need to make
genlock_device a mlstrustedobject if you want to allow direct writes by
apps, and you need to get that unlabeled file labeled with a type that
also has mlstrustedobject.

> Are there any easy ways (in seapp_contexts maybe?) to effectively turn
> off the MLS?

Sure, just remove the levelFromUid=true from all lines in
seapp_contexts, or at least for trusted_app.

>chcon'ing the dev file to have the c19 category the app was assigned
>broke access for other apps, so I can't help but wonder what the intent
>was of adding the categories to trusted apps?

Using per-app categories was to ensure that apps are truly isolated from
one another (unlike the existing per-app UIDs, which offers partial but
incomplete isolation and is vulnerable to malicious or flawed apps).
trusted_app doesn't mean fully trusted; it just distinguishes the system
apps from third party apps.  Also, if using our middleware MAC support,
you get a richer set of app domains based on app certificate rather than
just trusted_app vs untrusted_app.

Caveat:  We just merged Android 4.1/JellyBean to our master/seandroid
branch, so you likely don't want to use it at the moment.  But the
seandroid-4.0.4 or mmac-4.0.4 branches should be ok to use.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
