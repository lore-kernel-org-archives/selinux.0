Message-ID: <1345464637.10242.4.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: check_seapp script
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Mon, 20 Aug 2012 08:10:37 -0400
In-Reply-To: <CAFftDdoAjsGQNSmLTywoB0Pkq2q2uOARpv=R2sahvzS7TVannQ@mail.gmail.com>
References: 
	<CAFftDdoAjsGQNSmLTywoB0Pkq2q2uOARpv=R2sahvzS7TVannQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-17 at 18:36 -0700, William Roberts wrote:
> I wrote a script that will allow one to override seapp_contexts if you
> pass your concatenated seapp_contexts file through it.
> 
> For instance, suppose you have the following declarations in your seapp_contexts
> 
> user=app_* seinfo=release name=com.android.browser domain=browser_app
> type=platform_app_data_file
> user=app_* seinfo=release name=com.android.browser domain=browser_app
> type=new_thing
> 
> after running through the tool, such as
> ./check_seapp -o seapp_contexts seapp_contexts.intermediate
> 
> seapp_contacts will contain the following lines:
> user=app_* seinfo=release name=com.android.browser domain=browser_app
> type=new_thing
> 
> This is a first, rough draft. Comments on large flaws, or general
> acceptance are appreciated. We can focus on clean up later. Order
> matters, the last one with matching input selectors is the one chosen
> for output.

Seems basically sane, although the output isn't identical to the input
even in the case where no changes are made (whitespace difference -
trailing space).

> I was struggling under where this should be contained, sepolicy or
> checkpolicy, and for now, consider the code LGPL'd.

Android prefers ASL, as per:
http://source.android.com/source/licenses.html
although this may not be as crucial for a host-only tool.

sepolicy is presently public domain.
checkpolicy is presently GPLv2.

> I was also debating on whether or not to do this in python, but
> building for android
> (http://source.android.com/source/initializing.html) states that
> python is required.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
