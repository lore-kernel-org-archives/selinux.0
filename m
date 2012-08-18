MIME-Version: 1.0
In-Reply-To: <CAFftDdr-T4mUVF7gHfNG40HjyXhD7ohTU4JfN0d4NFtLXWFQEw@mail.gmail.com>
References: <CAFftDdoAjsGQNSmLTywoB0Pkq2q2uOARpv=R2sahvzS7TVannQ@mail.gmail.com>
	<CAFftDdr-T4mUVF7gHfNG40HjyXhD7ohTU4JfN0d4NFtLXWFQEw@mail.gmail.com>
Date: Fri, 17 Aug 2012 21:39:40 -0700
Message-ID: <CAFftDdoHDfwOLJ+LafeKYQ8kDcxPS0v2=0V665L1y+yURmRJBg@mail.gmail.com>
Subject: Re: [UPDATE] Re: check_seapp script
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was thinking of making the checks for types to make this more robust
and find errors at compile time, but then it would be beneficial to
use libselinux python bindings, which in turn would require building
those for the host and having python development headers installed.
Maybe I should just rewrite this in the future in C. Or should we see
if we can get python-dev headers added to the Android initializing the
build environment?

On Fri, Aug 17, 2012 at 7:22 PM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> Did some clean up to preserve ordering and enable a verbose mode.
>
> On Fri, Aug 17, 2012 at 6:36 PM, William Roberts
> <bill.c.roberts@gmail.com> wrote:
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
>>
>> I was struggling under where this should be contained, sepolicy or
>> checkpolicy, and for now, consider the code LGPL'd.
>>
>> I was also debating on whether or not to do this in python, but
>> building for android
>> (http://source.android.com/source/initializing.html) states that
>> python is required.
>>
>> --
>> Respectfully,
>>
>> William C Roberts
>
>
>
> --
> Respectfully,
>
> William C Roberts



-- 
Respectfully,

William C Roberts

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
