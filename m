MIME-Version: 1.0
In-Reply-To: <1350406303.13615.7.camel@moss-pluto.epoch.ncsc.mil>
References: <2236FBA76BA1254E88B949DDB74E612B19449DCA@IRSMSX102.ger.corp.intel.com>
	<5073D8D8.2010602@laiskiainen.org>
	<2236FBA76BA1254E88B949DDB74E612B1944A502@IRSMSX102.ger.corp.intel.com>
	<5075845F.9020102@laiskiainen.org>
	<2236FBA76BA1254E88B949DDB74E612B1944C1BE@IRSMSX102.ger.corp.intel.com>
	<507D3F47.4090100@laiskiainen.org>
	<2236FBA76BA1254E88B949DDB74E612B1944CA4E@IRSMSX102.ger.corp.intel.com>
	<1350406303.13615.7.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 17 Oct 2012 11:08:48 +0300
Message-ID: <CALrft98jehytyUGz5Q07+Qpn_10Rdvu2kw3hru0vu+y=9GXaxg@mail.gmail.com>
Subject: Re: First attempt for the patch on extending the plugin interface for rpm
From: Elena Reshetova <elena.reshetova@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
        Panu Matilainen <pmatilai@laiskiainen.org>,
        "tero.aho@nixu.com" <tero.aho@nixu.com>,
        "rpm-maint@lists.rpm.org" <rpm-maint@lists.rpm.org>,
        "Ware, Ryan R" <ryan.r.ware@intel.com>,
        "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>On Tue, Oct 16, 2012 at 7:51 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> @ Stephen, do you know how mandatory for SELinux is to have the whole argv
>> struct? Is it just because of rpm_execcon() API or?
>
> It is because presently rpm_execcon() performs the exec call.  If the
> exec call is handled by the caller, then we only need the executable
> path.  Likewise with envp; we do not need it if the caller performs the
> exec.  We would just move the remaining logic to set up the exec context
> from libselinux rpm_execcon() into the rpm selinux plugin code; as rpm
> is the only user of it, there is no real reason for it to live in
> libselinux vs being part of an rpm plugin.

Good, thank you for clarifying this! This is what I was hoping can be
the case. I will change the hook to have only path passed for now.

Best Regards,
Elena.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
