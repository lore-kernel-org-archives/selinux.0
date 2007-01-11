Message-ID: <45A6AA01.5070802@redhat.com>
Date: Thu, 11 Jan 2007 16:20:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: translation patch for semanage
References: <45A64526.2050701@redhat.com> <1168540385.7048.28.camel@localhost.localdomain>
In-Reply-To: <1168540385.7048.28.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Thu, 2007-01-11 at 09:09 -0500, Daniel J Walsh wrote:
>   
>> This patch works around a unicode problem in python.
>>     
>
> Can you give a little more detail - perhaps a BZ? It appears that this
> patch and the seobject patch or to force all translated strings to be
> unicode and output as unicode, correct? Why is this necessary?
>   
No this patch forces all output strings to be the locale default.  So it 
basically does the right thing.  BTW print works correctly.

I can not find any matching bugs on python source forge but trying to 
login there is causing me no end of head aches.  Asking people in the 
know around here, I get this response

+import codecs
> +import locale
> +sys.stderr =
> codecs.getwriter(locale.getpreferredencoding())(sys.__stderr__,'replace')
> 
> I was told by Ray that you knew about this problem in python?  Do you know if this is an open bug?


Don't know if it's an open bug per se; other than python is well known
to be broken w/ respect to codecs.

Thanks,
-Jonathan


>   
>> --- nsapolicycoreutils/semanage/semanage        2006-11-16
>> 17:14:26.000000000 -0500
>> +++ policycoreutils-1.33.10/semanage/semanage   2007-01-09
>> 11:55:52.000000000 -0500
>> @@ -23,12 +23,21 @@
>>  import os, sys, getopt
>>  import seobject
>>  import selinux
>> +PROGNAME="policycoreutils"
>> +
>>  import gettext
>> +gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
>>     
>
> Why is the location of the local files being forced? Is this appropriate
> for all distros or does it need to be configurable?
>
>   
>> +gettext.textdomain(PROGNAME)
>> +import codecs
>> +import locale
>> +sys.stderr =
>> codecs.getwriter(locale.getpreferredencoding())(sys.__stderr__,
>> 'replace')
>> +sys.stdout =
>> codecs.getwriter(locale.getpreferredencoding())(sys.__stdout__,
>> 'replace')
>>     
>
> Is this related to
> http://mail.python.org/pipermail/pythonmac-sig/2004-March/010651.html?
> I.e., is this to force the encoding rather than relying on the term to
> correctly communicate that it supports unicode / utf8 / etc.?
>
> If so, is this the "right" fix or just expedient?
>
> Karl
>  
>
>
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
