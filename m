Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8GFMwjr030277
	for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2009 11:22:58 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8GFMFxi013067
	for <selinux@tycho.nsa.gov>; Wed, 16 Sep 2009 15:22:15 GMT
Message-ID: <4AB102CE.3070102@manicmethod.com>
Date: Wed, 16 Sep 2009 11:22:54 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: libsemanage patch
References: <C6CBF8CF.AA709%csellers@tresys.com>
In-Reply-To: <C6CBF8CF.AA709%csellers@tresys.com>
Content-Type: multipart/alternative;
 boundary="------------070500020009080502010609"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070500020009080502010609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Chad Sellers wrote:
> On 9/7/09 6:44 AM, "Daniel J Walsh"<dwalsh@redhat.com>  wrote:
>
>    
>> On 09/04/2009 09:56 AM, Joshua Brindle wrote:
>>      
>>> Daniel J Walsh wrote:
>>>        
>>>> If you have a homedir that ends in '/', genhomedircon gets confused.
>>>>
>>>> # useradd -h /home2/dwalsh/ dwalsh
>>>> # genhomedircon
>>>>
>>>> Check out the labeling.  genhomedircon thinks dwalsh is a toplevel
>>>> home root.
>>>>
>>>> We should just get rid of this command...  :^)
>>>>
>>>> Patch removes all trailing '/' from homedir.
>>>>          
>>>> diff --exclude-from=exclude -N -u -r
>>>> nsalibsemanage/src/genhomedircon.c libsemanage-2.0.33/src/genhomedircon.c
>>>> --- nsalibsemanage/src/genhomedircon.c    2008-08-28
>>>> 09:34:24.000000000 -0400
>>>> +++ libsemanage-2.0.33/src/genhomedircon.c    2009-07-15
>>>> 10:32:20.000000000 -0400
>>>> @@ -304,6 +304,10 @@
>>>>               continue;
>>>>           if (!semanage_list_find(shells, pwbuf->pw_shell))
>>>>               continue;
>>>> +        int len = strlen(pwbuf->pw_dir) -1;
>>>> +        for(; len>  0&&  pwbuf->pw_dir[len]=='/'; len--) {
>>>> +            pwbuf->pw_dir[len]=0;
>>>> +        }
>>>>           if (strcmp(pwbuf->pw_dir, "/") == 0)
>>>>               continue;
>>>>           if (semanage_str_count(pwbuf->pw_dir, '/')<= 1)
>>>>          
>>> Why aren't you just doing:
>>>
>>> len = strlen(pwbuf->pwdir);
>>> if (pwbuf->pwdir[len] == '/')
>>>      pwbuf->pwdir[len] = '\0';
>>>
>>> ?
>>>
>>>        
>> What about /home/dwalsh//////
>> Which I believe is legal
>>      
>>> Also, won't this fail if the homedir is set to '/' ? This check should
>>> probably go below the strcmp(pwbuf->pw_dir, "/") that is currently below
>>> it.
>>>        
>> Yes good point.
>>
>>      
> I thought it worked fine with '/'. Since the loop condition is len>  0
> (where len is the index of the last character, not the length of the string,
> which is a bit confusing and should probably be changed), it would never
> reset the first character. And don't you want this before the
> strcmp(pwbuf->pw_dir, "/") in case the path is ///// (which would of course
> be silly, but I believe is legal anyway)?
>
> Chad
>
>    

Yep, got it.

Acked-By: Joshua Brindle <method@manicmethod.com>

--------------070500020009080502010609
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
Chad Sellers wrote:
<blockquote cite="mid:C6CBF8CF.AA709%25csellers@tresys.com" type="cite">
  <pre wrap="">On 9/7/09 6:44 AM, "Daniel J Walsh" <a class="moz-txt-link-rfc2396E" href="mailto:dwalsh@redhat.com">&lt;dwalsh@redhat.com&gt;</a> wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">On 09/04/2009 09:56 AM, Joshua Brindle wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Daniel J Walsh wrote:
      </pre>
      <blockquote type="cite">
        <pre wrap="">If you have a homedir that ends in '/', genhomedircon gets confused.

# useradd -h /home2/dwalsh/ dwalsh
# genhomedircon

Check out the labeling.  genhomedircon thinks dwalsh is a toplevel
home root.

We should just get rid of this command...  :^)

Patch removes all trailing '/' from homedir.
        </pre>
      </blockquote>
      <blockquote type="cite">
        <pre wrap="">diff --exclude-from=exclude -N -u -r
nsalibsemanage/src/genhomedircon.c libsemanage-2.0.33/src/genhomedircon.c
--- nsalibsemanage/src/genhomedircon.c    2008-08-28
09:34:24.000000000 -0400
+++ libsemanage-2.0.33/src/genhomedircon.c    2009-07-15
10:32:20.000000000 -0400
@@ -304,6 +304,10 @@
             continue;
         if (!semanage_list_find(shells, pwbuf-&gt;pw_shell))
             continue;
+        int len = strlen(pwbuf-&gt;pw_dir) -1;
+        for(; len &gt; 0 &amp;&amp; pwbuf-&gt;pw_dir[len]=='/'; len--) {
+            pwbuf-&gt;pw_dir[len]=0;
+        }
         if (strcmp(pwbuf-&gt;pw_dir, "/") == 0)
             continue;
         if (semanage_str_count(pwbuf-&gt;pw_dir, '/') &lt;= 1)
        </pre>
      </blockquote>
      <pre wrap="">Why aren't you just doing:

len = strlen(pwbuf-&gt;pwdir);
if (pwbuf-&gt;pwdir[len] == '/')
    pwbuf-&gt;pwdir[len] = '\0';

?

      </pre>
    </blockquote>
    <pre wrap="">What about /home/dwalsh//////
Which I believe is legal
    </pre>
    <blockquote type="cite">
      <pre wrap="">Also, won't this fail if the homedir is set to '/' ? This check should
probably go below the strcmp(pwbuf-&gt;pw_dir, "/") that is currently below
it.
      </pre>
    </blockquote>
    <pre wrap="">Yes good point.

    </pre>
  </blockquote>
  <pre wrap=""><!---->I thought it worked fine with '/'. Since the loop condition is len &gt; 0
(where len is the index of the last character, not the length of the string,
which is a bit confusing and should probably be changed), it would never
reset the first character. And don't you want this before the
strcmp(pwbuf-&gt;pw_dir, "/") in case the path is ///// (which would of course
be silly, but I believe is legal anyway)?

Chad

  </pre>
</blockquote>
<br>
Yep, got it. <br>
<br>
Acked-By: Joshua Brindle <a class="moz-txt-link-rfc2396E" href="mailto:method@manicmethod.com">&lt;method@manicmethod.com&gt;</a><br>
</body>
</html>

--------------070500020009080502010609--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
