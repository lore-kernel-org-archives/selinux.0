From: "Leslie J. French" <ljf@semandex.net>
To: "Russell Coker" <russell@coker.com.au>
Cc: "SELinux" <SELinux@tycho.nsa.gov>
Subject: RE: poweroff problem?
Date: Sun, 7 Jul 2002 20:00:13 -0400
Message-ID: <BFEMIIHKHLALNELLMPOMOEKECBAA.ljf@semandex.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20020707133402.8E1613062@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>On Sat, 6 Jul 2002 11:35, Leslie J. French wrote:
>> And there are a lot of avc violations associated with killall from apmd_t
>> to various other types (e.g. kernet_t).  This is as "out of the box" as I
>> can make my system, none of my users or domains are in the system, and
I'm
>> using the .te and .fc files directly from the distribution.
>
>Reporting that there are "a lot of errors" doesn't really help us.  You
need
>to provide samples of these errors (and making sure that you spell them
>correctly is important too - there has never been a kernet_t).

-- Noted, though I was just polling to see if there was an obvious answer
before filling the list with a dmesg trace etc.

Anyway, with some random changes to the LSM config file it now works -- I
don't know which set of options stopped it, and which restored it.  I did
remove the "use APM bios for poweroff" option though!

Leslie


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
