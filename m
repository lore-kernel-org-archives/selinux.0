Message-ID: <1341866938.10134.23.camel@moss-pluto.epoch.ncsc.mil>
Subject: SE Android (Was: Re: Welcome to selinux)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Mon, 09 Jul 2012 16:48:58 -0400
In-Reply-To: <CAKi3PupzMRZsYzPAj_U0ff_QyN1VJUkVB9mciL=D_K3Hinm5AQ@mail.gmail.com>
References: <201206211329.q5LDT6PW031262@tarius.tycho.ncsc.mil>
	 <CAKi3Pur-Ne8vAfbw6t4hutrqJO73x=wOaHvTg8dca4W-LUOuLg@mail.gmail.com>
	 <1340288275.4234.48.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3PuqSFBw8EHLCXuASBxoMEEX4wTuW0MZOdEURO5_GWTVcnA@mail.gmail.com>
	 <CAKi3PurC2T92r2mhzPKj7WoYb0Rf5Foz3W332Nov=Q5HZ8Ac3g@mail.gmail.com>
	 <CAKi3Puqf0u=H379cBk+uXtSNCbpQjtM-cDcyTifDGG8CdV93nA@mail.gmail.com>
	 <1340980684.15948.7.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3PupzMRZsYzPAj_U0ff_QyN1VJUkVB9mciL=D_K3Hinm5AQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-07-02 at 16:05 +0200, Alexandra Test wrote:

> I tried to install application from the google play website directly
> from the phone but it is not working. 

Not sure what you mean by "not working" above.  You have to separately
install the gapps, but they work for us.  Enforcing or permissive?

> How to get the formal meaning of the files? I tried to look for it...

seapp_contexts is only "documented" by the inline comments at the
moment.  The SELinux policy language is documented in a variety of
places, including books (e.g. SELinux by Example, the SELinux Notebook),
wiki pages (e.g. http://selinuxproject.org/page/PolicyLanguage), and
technical reports (e.g.
http://www.nsa.gov/research/selinux/docs.shtml#tech).

> Yes, you are right, but I can't see any deny now... I only have to
> understand how to go on...  

No avc messages in the output of adb shell dmesg or adb logcat?


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
