Message-ID: <1330960184.1841.17.camel@moss-lions.epoch.ncsc.mil>
Subject: Re: SE Android and Finer Grained Permissions
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: noloader@gmail.com
Cc: SE Linux <SELinux@tycho.nsa.gov>
Date: Mon, 05 Mar 2012 10:09:44 -0500
In-Reply-To: <CAH8yC8kE6fEGijSyjz4_VrqoogbrqLAsHwCXsRQH3qd52e=kVw@mail.gmail.com>
References: 
	<CAH8yC8kE6fEGijSyjz4_VrqoogbrqLAsHwCXsRQH3qd52e=kVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2012-03-04 at 21:02 -0500, Jeffrey Walton wrote:
> Hi All,
> 
> Forgive my ignorance here.....
> 
> I was reading the slides at on SE Android at
> http://selinuxproject.org/~jmorris/lss2011_slides/caseforseandroid.pdf.
> 
> I see the slides point out "[Current Android suffers] limited
> granularity, coarse-grained privilege." But I don't see where SE
> Android corrected it. For example, it appears READ_PHONE_STATE still
> encompasses reading a device serial number, IMEI, SIM ID, call state,
> incoming calling number, etc.
> 
> Does SE Android remediate the coarse grained permissions?
> 

No. Currently, the SE Android policy is only trying to ensure that the
existing Android security model is enforced. The Android permissions
work exactly the same way.

SE Android is still a work in progress. Our goal is to extend security
controls into the application frameworks of Android to better control
applications and that could eventually lead to finer-grained control
over resources currently controlled by Android permissions.

> Is an application installation still an "all or nothing" proposition
> with respect to permissions? For example, can I approve an install and
> later take away the WRITE_CONTACTS permission?
> 

As I mentioned above, SE Android currently does not change the Android
security model.
-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
