Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAKK4NAx007318
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 15:04:23 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAKK3cHO021140
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 20:03:39 GMT
Message-ID: <45620A3A.1060805@mentalrootkit.com>
Date: Mon, 20 Nov 2006 15:04:10 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Yuichi Nakamura <ynakam@gwu.edu>, selinux@tycho.nsa.gov
Subject: Re: Question about setsebool.c
References: <dca487e823b48.4561eda4@gwu.edu> <4561D175.6050309@mentalrootkit.com> <4561F668.8070207@tresys.com>
In-Reply-To: <4561F668.8070207@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Karl MacMillan wrote:
>> Yuichi Nakamura wrote:
>>> Hi, I looked at the latest policycoreutils code.
>>> (policycoreutils-1.33.1-9.fc7.src.rpm)
>>>
>>> And found strange code, in setsebool.c.
>>>
>>>     94  /* Apply (permanent) boolean changes to policy via 
>>> libsemanage */
>>>     95  static int semanage_set_boolean_list(size_t boolcnt,
>>>     96                                       SELboolean * boollist, 
>>> int perm)
>>>     97  {
>>>    <snip>
>>>    117          } else if (managed == 0) {
>>>    118                  if (selinux_set_boolean_list(boolcnt, 
>>> boollist, 1) < 0)
>>>    119                          goto err;
>>>    120                  goto out;
>>>    121          }
>>>
>>> Why 3rd arg for selinux_set_boolean_list is "1"?
>>> Should it be "perm"?
>>>
>>
>> Looks that way to me. Additionally, is it even possible to make 
>> non-permanent change to a boolean via semanage? If not, then this code 
>> path should check for that. Josh?
>>
> libsemanage is only responsible for the persistent changes,

That is not how the current setsebool.c code works - see:

if (perm
     && semanage_bool_modify_local(handle, bool_key, boolean) < 0)
	goto err;

Testing confirms that this allows setting non-persistent booleans via 
semanage using setsebool.

  sesetbool
> sets the non-persistent directly, in fact demonstrated by the code 
> snippet above. This does look like a bug and if someone uses setsebool 
> to set a non-persistent boolean on an unmanaged system it appears that 
> it will indeed make it permanent.
> 

What about this:

diff -r 130ab1cdcc3a policycoreutils/setsebool/setsebool.c
--- a/policycoreutils/setsebool/setsebool.c	Thu Nov 16 17:11:37 2006 -0500
+++ b/policycoreutils/setsebool/setsebool.c	Mon Nov 20 15:01:14 2006 -0500
@@ -115,7 +115,7 @@ static int semanage_set_boolean_list(siz
  		goto err;

  	} else if (managed == 0) {
-		if (selinux_set_boolean_list(boolcnt, boollist, 1) < 0)
+		if (selinux_set_boolean_list(boolcnt, boollist, perm) < 0)
  			goto err;
  		goto out;
  	}

Signed-off-by Karl MacMillan <kmacmillan@mentalrootkit.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
