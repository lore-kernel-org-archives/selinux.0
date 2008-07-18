Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6IGIOMm017770
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 12:18:24 -0400
Received: from ag-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6IGIN29017670
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 16:18:23 GMT
Received: by ag-out-0708.google.com with SMTP id 8so8262852agc.0
        for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2008 09:18:23 -0700 (PDT)
Message-ID: <dd18b0c30807180918l5883fa40pe15530585ab320f1@mail.gmail.com>
Date: Fri, 18 Jul 2008 16:18:23 +0000
From: "Justin Mattock" <justinmattock@gmail.com>
To: "Dominick Grift" <domg472@gmail.com>
Subject: Re: firefox3
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1216382832.8282.27.camel@sulphur.notebook.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <dd18b0c30807171539m772f87fh64f706e8f9cf0e9e@mail.gmail.com>
	 <1216382832.8282.27.camel@sulphur.notebook.internal>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jul 18, 2008 at 12:07 PM, Dominick Grift <domg472@gmail.com> wrote:
> On Thu, 2008-07-17 at 22:39 +0000, Justin Mattock wrote:
>> I'm trying to tighten up firefox, from what I can see over here:
>
> I do not encourage people to run Firefox as sysadm_t, and i recommend
> you use staff_t as your default domain. Sysadm_t is a domain specific
> just for sysadmin tasks. Plus sysadm_t is being (kind of) replaced by
> unconfined_t in the targeted policy.
>
> Also i think sysadm, user and staff do not transition once they run
> Firefox, but that they run Firefox in the user domain by default.
>
> In Fedora 9 only xguest_t domain by default can run Firefox in the
> Mozilla domain by setting the boolean.
>
> However Nsplugin is now by default confined to the nsplugin_t domain and
> so even though you may not transition to mozilla_t as staff or user, you
> will still be protected by nsplugin_t.
>
> To see in what domain Firefox is running execute ps auxZ | grep -i
> firefox.
> --
> Dominick Grift <domg472@gmail.com>
>

Hello;
when doing ps I see firefox as what I had intended it
to be in user_r:user_t, The interesting thing that I'm seeing
is firefox will start under sysadm_r. when it shouldn't.
Now keep in mind this is something I've noticed with the new firefox3
the beta version of firefox3 was using gconf differently.
from looking at the allow rules maybe:
allow user_mozilla_t sysadm_gconf_home_t:dir { add_name getattr read
remove_name search write };
allow user_mozilla_t sysadm_gconf_home_t:file { append create getattr
read rename unlink write };
is what is causing sysadm to start firefox.(now from what I'm seeing
even though sysadm can start firefox, you can't do much with it due to the
rules not being defined. it's more of a question to me as to why
is it starting in that role. Anyways I'll have a look into my other rules
that might be causing this; just to be safe.
regards;

-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
