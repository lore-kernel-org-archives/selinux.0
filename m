Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA11606
	for <selinux@tycho.nsa.gov>; Sun, 3 Mar 2002 00:29:00 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id FAA26078
	for <selinux@tycho.nsa.gov>; Sun, 3 Mar 2002 05:27:55 GMT
Received: from mail.outstep.com (a904j637.tower.wayne.edu [141.217.140.65])
        by jazzband.ncsc.mil  with ESMTP id FAA26074 for <selinux@tycho.nsa.gov>; Sun, 3 Mar 2002 05:27:55 GMT
Message-ID: <4699.192.168.1.12.1015132950.squirrel@192.168.1.2>
Date: Sun, 3 Mar 2002 00:22:30 -0500 (EST)
Subject: Re: pppd_t domain
From: "Lonnie Cumberland" <lonnie@outstep.com>
To: <russell@coker.com.au>
In-Reply-To: <20020303013636.294771513@lyta.coker.com.au>
References: <20020303013636.294771513@lyta.coker.com.au>
Cc: <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Russell,

Thanks for replying to my email. I have also download and printed out
all of the SELinux documantation to try and get a better feel for
things.

I am sorry to bother you again but I made the changes to the device
file and now when I do a "make load" I get an error:

------------------------------------------------
/usr/local/selinux/bin/checkpolicy:  loading policy configuration
from policy.conf

error in the statement ending on line 25168 (token ';'): unknown type
mesg_t

/usr/local/selinux/bin/checkpolicy:  error(s) encountered while
parsing configuration
make: *** [policy] Error 1
--------------------------------------------------------

I will now try and go through the archives to see if something in
there can clear things up a little as I am just trying to get your
pppd.te instadded an working.

Thanks again,
Lonnie


> On Sat, 2 Mar 2002 19:38, you wrote:
>> I was trying to get your pppd.te file installed but whne I did
>> a "make load" I get:
>> error in the statement ending on line 12200 (token ';'): unknown
>> type net_device_t
>
> You need something like the following in types/device.te:
> # net_device_t is the type of /dev/ppp
> type net_device_t, file_type;
>
>> You mentioned that:
>> > Also /dev/ppp has to have the SID
>> > system_u:object_r:net_device_t, use  devfs_contexts if you
>> > have devfs or file_contexts and a
>> > relabel otherwise (or  just a chsid as a faster alternative to
>> > a relabel).
>>
>> but I am a little unclear as to what I need to do exactly.
>
> Firstly familiarise yourself with chsid/chcon and the
> file_contexts file.  If  you check the list archives you should
> see some messages explaining all this.
>
>> Also, how do I add the pptp vpn daemon to this as well so that I
>> will not get the errors in SELinux and so that my vpn can make
>> the
>> connection.
>
> Not sure.  Never tried doing that.  Start with what I've done for
> pppd and  just play with it.
>
> Most of the SE Linux stuff is not properly documented.  Reading
> the source  code helps.
>
> --
> If you send email to me or to a mailing list that I use which has
> >4 lines of legalistic junk at the end then you are specifically
> authorizing me to do whatever I wish with the message and all
> other messages from your domain, by posting the message you agree
> that your long legalistic sig is void.


-- 
 Lonnie Cumberland
 OutStep Technologies Incorporated
 EMAIL: Lonnie@OutStep.com
      : Lonnie_Cumberland@yahoo.com

 The Basis Express Virtual Office
               &
 Data Backup and Recovery Services

 URL: http://www.basis-express.com

"The Virtual Office without boundries!!!"





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
