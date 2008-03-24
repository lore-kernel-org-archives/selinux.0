Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2OHbKS1027444
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 13:37:20 -0400
Received: from rv-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2OHb2QR021865
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 17:37:17 GMT
Received: by rv-out-0910.google.com with SMTP id k15so1428549rvb.54
        for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2008 10:36:50 -0700 (PDT)
Message-ID: <50771f160803241029r41c75d93r6babbd5d911a305a@mail.gmail.com>
Date: Mon, 24 Mar 2008 14:29:40 -0300
From: "cinthya aranguren" <cinthya.aranguren@gmail.com>
To: casey@schaufler-ca.com
Subject: Re: Removing DAC.
Cc: selinux@tycho.nsa.gov
In-Reply-To: <404587.40497.qm@web36614.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <613578.78683.qm@web36601.mail.mud.yahoo.com>
	 <404587.40497.qm@web36614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Mar 23, 2008 at 2:40 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>  --- Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>  >
>  > --- cinthya aranguren <cinthya.aranguren@gmail.com> wrote:
>  >
>  > > Hi,
>  > >
>  > > Is there any way to avoid o remove DAC controls ? I'd like to have only one
>  > > security scheme in my system. I mean a pure SElinux system. not DAC + MAC.
>  > > only MAC.
>  >
>  > No.
>  >
>  > Well, not today.
>
>  I will add that if every process runs with CAP_DAC_OVERRIDE set
>  you can approach "no DAC", but I think you would probably have
>  to dig very deeply into the behavior of security cognizant
>  applications (sendmail comes to mind) and make sure that they
>  aren't explictly dropping that capability. I will let those
>  who work more closely with SELinux policy than I do describe
>  how capabilities possessed are related to an SELinux policy
>  and how that might impact the behavior of SELinux. You should
>  also note that SELinux takes what are traditionally DAC
>  attributes into account when making decisions and that if you
>  use MCS you are using a DAC mechanism within SELinux. I'm not
>  saying that's bad, just that it's there.
>

This is a good point. I will experiment with CAP_DAC_OVERRIDE.
but .. why SELinux take DAC attributes into account when making
decisions ?? this does not violate the separation of "policy" from
"Enforcement" ??


>
>
>
>  Casey Schaufler
>  casey@schaufler-ca.com
>

Cinthya.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
