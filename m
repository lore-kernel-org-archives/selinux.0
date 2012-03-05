MIME-Version: 1.0
Reply-To: noloader@gmail.com
Date: Sun, 4 Mar 2012 21:02:47 -0500
Message-ID: <CAH8yC8kE6fEGijSyjz4_VrqoogbrqLAsHwCXsRQH3qd52e=kVw@mail.gmail.com>
Subject: SE Android and Finer Grained Permissions
From: Jeffrey Walton <noloader@gmail.com>
To: SE Linux <SELinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

Forgive my ignorance here.....

I was reading the slides at on SE Android at
http://selinuxproject.org/~jmorris/lss2011_slides/caseforseandroid.pdf.

I see the slides point out "[Current Android suffers] limited
granularity, coarse-grained privilege." But I don't see where SE
Android corrected it. For example, it appears READ_PHONE_STATE still
encompasses reading a device serial number, IMEI, SIM ID, call state,
incoming calling number, etc.

Does SE Android remediate the coarse grained permissions?

Is an application installation still an "all or nothing" proposition
with respect to permissions? For example, can I approve an install and
later take away the WRITE_CONTACTS permission?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
