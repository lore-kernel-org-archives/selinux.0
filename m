Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAKIdSJw004676
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 13:39:28 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kAKIbmEc013663
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 18:37:49 GMT
Message-ID: <4561F668.8070207@tresys.com>
Date: Mon, 20 Nov 2006 13:39:36 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Yuichi Nakamura <ynakam@gwu.edu>, selinux@tycho.nsa.gov
Subject: Re: Question about setsebool.c
References: <dca487e823b48.4561eda4@gwu.edu> <4561D175.6050309@mentalrootkit.com>
In-Reply-To: <4561D175.6050309@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> Yuichi Nakamura wrote:
>> Hi, I looked at the latest policycoreutils code.
>> (policycoreutils-1.33.1-9.fc7.src.rpm)
>>
>> And found strange code, in setsebool.c.
>>
>>     94  /* Apply (permanent) boolean changes to policy via 
>> libsemanage */
>>     95  static int semanage_set_boolean_list(size_t boolcnt,
>>     96                                       SELboolean * boollist, 
>> int perm)
>>     97  {
>>    <snip>
>>    117          } else if (managed == 0) {
>>    118                  if (selinux_set_boolean_list(boolcnt, 
>> boollist, 1) < 0)
>>    119                          goto err;
>>    120                  goto out;
>>    121          }
>>
>> Why 3rd arg for selinux_set_boolean_list is "1"?
>> Should it be "perm"?
>>
>
> Looks that way to me. Additionally, is it even possible to make 
> non-permanent change to a boolean via semanage? If not, then this code 
> path should check for that. Josh?
>
libsemanage is only responsible for the persistent changes, sesetbool 
sets the non-persistent directly, in fact demonstrated by the code 
snippet above. This does look like a bug and if someone uses setsebool 
to set a non-persistent boolean on an unmanaged system it appears that 
it will indeed make it permanent.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
