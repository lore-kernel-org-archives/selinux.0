MIME-Version: 1.0
In-Reply-To: <1345464637.10242.4.camel@moss-pluto.epoch.ncsc.mil>
References: <CAFftDdoAjsGQNSmLTywoB0Pkq2q2uOARpv=R2sahvzS7TVannQ@mail.gmail.com>
	<1345464637.10242.4.camel@moss-pluto.epoch.ncsc.mil>
Date: Mon, 20 Aug 2012 05:20:32 -0700
Message-ID: <CAFftDdreqjVXa0Rq43TATLb5OdNU+9bkTvxZ=r_foiqh0HxxQg@mail.gmail.com>
Subject: Re: check_seapp script
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ill fix the white space issue, I didn't check for that, I just checked
the ordering. Do you want this under check policy with a GPL license?
None of the current projects (sepolicy and check policy) are ASL?

Give me a few days to get back to this, I am out until Thursday.

Bill

On Mon, Aug 20, 2012 at 5:10 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Fri, 2012-08-17 at 18:36 -0700, William Roberts wrote:
>> I wrote a script that will allow one to override seapp_contexts if you
>> pass your concatenated seapp_contexts file through it.
>>
>> For instance, suppose you have the following declarations in your seapp_contexts
>>
>> user=app_* seinfo=release name=com.android.browser domain=browser_app
>> type=platform_app_data_file
>> user=app_* seinfo=release name=com.android.browser domain=browser_app
>> type=new_thing
>>
>> after running through the tool, such as
>> ./check_seapp -o seapp_contexts seapp_contexts.intermediate
>>
>> seapp_contacts will contain the following lines:
>> user=app_* seinfo=release name=com.android.browser domain=browser_app
>> type=new_thing
>>
>> This is a first, rough draft. Comments on large flaws, or general
>> acceptance are appreciated. We can focus on clean up later. Order
>> matters, the last one with matching input selectors is the one chosen
>> for output.
>
> Seems basically sane, although the output isn't identical to the input
> even in the case where no changes are made (whitespace difference -
> trailing space).
>
>> I was struggling under where this should be contained, sepolicy or
>> checkpolicy, and for now, consider the code LGPL'd.
>
> Android prefers ASL, as per:
> http://source.android.com/source/licenses.html
> although this may not be as crucial for a host-only tool.
>
> sepolicy is presently public domain.
> checkpolicy is presently GPLv2.
>
>> I was also debating on whether or not to do this in python, but
>> building for android
>> (http://source.android.com/source/initializing.html) states that
>> python is required.
>
> --
> Stephen Smalley
> National Security Agency
>



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
