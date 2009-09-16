Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8GEl9WG024251
	for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2009 10:47:09 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8GEkQxi024403
	for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2009 14:46:26 GMT
Message-ID: <4AB0FA6A.7010206@manicmethod.com>
Date: Wed, 16 Sep 2009 10:47:06 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] policAycoreutils: share setfiles restore function
 with restorecond
References: <1250711251.2835.25.camel@Hephaestus> <4A8C683F.8070005@manicmethod.com> <4A8C6F26.6080304@redhat.com> <4A8D5A8F.8060306@manicmethod.com> <4A8D8BBD.80600@redhat.com>
In-Reply-To: <4A8D8BBD.80600@redhat.com>
Content-Type: multipart/alternative;
 boundary="------------010404050209040805070001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010404050209040805070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Daniel J Walsh wrote:
> On 08/20/2009 10:15 AM, Joshua Brindle wrote:
>    
>> Daniel J Walsh wrote:
>>      
>>> On 08/19/2009 05:01 PM, Joshua Brindle wrote:
>>>        
>>>> Thomas Liu wrote:
>>>>          
>>>>> This patch edits restorecond to use the shared restore
>>>>>
>>>>> functions split out from the first patch in this series.
>>>>>
>>>>>            
>>>> Is the DBus stuff in here suppose to be here? It looks like you are
>>>> adding libdbus and include dirs but I don't see any dbus usage.
>>>>
>>>>          
>> <snip>
>>      
>>> restorcond -u is a dbus session bus service.
>>>
>>> The idea is to run restorecond as your UID when you log into a console
>>> session.
>>>
>>>        
>> Maybe I don't get how DBus works. Why are the include dirs added to
>> CFLAGS but no apparent dbus #includes?
>>
>> Further, will this _only_ work with DBus after this patch? If so there
>> needs to be a way to not build it if dbus isn't present on the system
>> (embedded).
>>
>> -- 
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>>
>>
>>      
> Ok here is another patch with all of the dbus stuff aggregated under a HAVE_DBUS flag.
>
> You can build it with or without DBUS support and it should work fine.
>
> DBUS is really used to make sure multiple restorecond do not get started.
>    

This patch got badly broken by a few recent commits, which is totally my 
fault for not applying it earlier. I'll try to rebase it but my main 
objection is that restorecond is now using object files from setfiles. I 
know they are in the same 'package' but they are separate apps. Maybe we 
should move restore.{c,h} to policycoreutils/common or something.


--------------010404050209040805070001
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body text="#000000" bgcolor="#ffffff">
<br>
<br>
Daniel J Walsh wrote:
<blockquote cite="mid:4A8D8BBD.80600@redhat.com" type="cite">
  <pre wrap="">On 08/20/2009 10:15 AM, Joshua Brindle wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Daniel J Walsh wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">On 08/19/2009 05:01 PM, Joshua Brindle wrote:
      </pre>
      <blockquote type="cite">
        <pre wrap="">Thomas Liu wrote:
        </pre>
        <blockquote type="cite">
          <pre wrap="">This patch edits restorecond to use the shared restore

functions split out from the first patch in this series.

          </pre>
        </blockquote>
        <pre wrap="">Is the DBus stuff in here suppose to be here? It looks like you are
adding libdbus and include dirs but I don't see any dbus usage.

        </pre>
      </blockquote>
    </blockquote>
    <pre wrap="">&lt;snip&gt;
    </pre>
    <blockquote type="cite">
      <pre wrap="">restorcond -u is a dbus session bus service.

The idea is to run restorecond as your UID when you log into a console
session.

      </pre>
    </blockquote>
    <pre wrap="">Maybe I don't get how DBus works. Why are the include dirs added to
CFLAGS but no apparent dbus #includes?

Further, will this _only_ work with DBus after this patch? If so there
needs to be a way to not build it if dbus isn't present on the system
(embedded).

-- 
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to <a class="moz-txt-link-abbreviated" href="mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a>
with
the words "unsubscribe selinux" without quotes as the message.


    </pre>
  </blockquote>
  <pre wrap=""><!---->Ok here is another patch with all of the dbus stuff aggregated under a HAVE_DBUS flag.

You can build it with or without DBUS support and it should work fine.

DBUS is really used to make sure multiple restorecond do not get started.
  </pre>
</blockquote>
<br>
This patch got badly broken by a few recent commits, which is totally
my fault for not applying it earlier. I'll try to rebase it but my main
objection is that restorecond is now using object files from setfiles.
I know they are in the same 'package' but they are separate apps. Maybe
we should move restore.{c,h} to policycoreutils/common or something.<br>
<br>
</body>
</html>

--------------010404050209040805070001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
