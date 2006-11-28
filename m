Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kASGQ5N4010990
	for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2006 11:26:05 -0500
Received: from wr-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kASGOMnt022791
	for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2006 16:24:22 GMT
Received: by wr-out-0506.google.com with SMTP id 57so446656wri
        for <selinux@tycho.nsa.gov>; Tue, 28 Nov 2006 08:26:26 -0800 (PST)
Message-ID: <e294b46e0611280826m33aaa2bkdf25270cab035c69@mail.gmail.com>
Date: Tue, 28 Nov 2006 16:26:26 +0000
From: "Bradley Chapman" <kakadu@gmail.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [RFC] Thunar filesystem manager policy
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1164728200.8768.9.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <e294b46e0611221141v650500f7v72f83ecd3573e356@mail.gmail.com>
	 <1164637648.7490.18.camel@sgc.columbia.tresys.com>
	 <e294b46e0611280651w7e9b0f8fp8a321f8c8b40513b@mail.gmail.com>
	 <1164728200.8768.9.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. PeBenito,

On 11/28/06, Christopher J. PeBenito <cpebenito@tresys.com> wrote:
> That explains the $1_thunar_t, but what about thunar_t?  From the
> policy, it looks like a daemon.

It is - it gets started by dbus-daemon from staff_dbusd_t when logging
into the windowing environment, and runs in the background as a
daemon. Though for some reason dbus-daemon still isn't transitioning
from staff_dbusd_t to staff_thunar_t when starting Thunar - as a
result I'm getting errors due to staff_t and staff_dbusd_t accessing
staff_thunar_*_t files...

>
> As I noted before, there are no rules for this.  Because of
> libs_exec_lib_files(thunar_t), it seems to me that these scripts were
> actually labeled lib_t.  My feeling is that this extra type is not
> needed, and the scripts might be better off as bin_t.

Maybe so. I'll take a second look after I get the domain transitions sorted out.

>
> >  thunar_etc_t, OTOH, was
> > added mainly because I didn't want to give Thunar full access to /etc.
>
> It seems very odd to me that a user application would be writing to
> files in /etc.

But it does - /etc/xdg/Thunar/uca.xml is the file in question.

Brad
-- 
CONTROL YOUR TABS: https://addons.mozilla.org/extensions/158

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
