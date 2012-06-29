Message-ID: <1340980684.15948.7.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Welcome to selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 29 Jun 2012 10:38:04 -0400
In-Reply-To: <CAKi3Puqf0u=H379cBk+uXtSNCbpQjtM-cDcyTifDGG8CdV93nA@mail.gmail.com>
References: <201206211329.q5LDT6PW031262@tarius.tycho.ncsc.mil>
	 <CAKi3Pur-Ne8vAfbw6t4hutrqJO73x=wOaHvTg8dca4W-LUOuLg@mail.gmail.com>
	 <1340288275.4234.48.camel@moss-pluto.epoch.ncsc.mil>
	 <CAKi3PuqSFBw8EHLCXuASBxoMEEX4wTuW0MZOdEURO5_GWTVcnA@mail.gmail.com>
	 <CAKi3PurC2T92r2mhzPKj7WoYb0Rf5Foz3W332Nov=Q5HZ8Ac3g@mail.gmail.com>
	 <CAKi3Puqf0u=H379cBk+uXtSNCbpQjtM-cDcyTifDGG8CdV93nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-06-29 at 15:59 +0200, Alexandra Test wrote:
> Hi,
> sorry for all the mails!
> I installed SeAndroid but I have some problems.
> - the camera is not working (is it normal?)

That's not SE Android related - it is a general AOSP issue; see
discussions on android-building.  The extract-files.sh script from the
per-device directory may help you.

> i would like to install other applications but I really didn't get how
> to do that.
> should I install the application and then define new policies?

Yes, although you shouldn't need a new policy for each app; policy is
written in terms of types (equivalence classes).

> How to define the policies?

If using the middleware MAC support, you would amend the
external/mac-policy/mac_permissions.xml configuration.  For the SELinux
policy, you would possibly amend external/sepolicy/seapp_contexts if you
want to label the app differently and you might amend the rules in
external/sepolicy/app.te.

> then I notice that I have some residual denials to address in my
> policy.
> I hope I will find a way and I am really sorry but I am a beginner! 

Best thing to do is to post the denials and let people help you
understand what they mean and how to start addressing them.  Once you've
done it for a few denials, you'll pick it up.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
