Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAKG26xE032208
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 11:02:06 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAKG0P6E005105
	for <selinux@tycho.nsa.gov>; Mon, 20 Nov 2006 16:00:26 GMT
Message-ID: <4561D175.6050309@mentalrootkit.com>
Date: Mon, 20 Nov 2006 11:01:57 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Yuichi Nakamura <ynakam@gwu.edu>
CC: selinux@tycho.nsa.gov
Subject: Re: Question about setsebool.c
References: <dca487e823b48.4561eda4@gwu.edu>
In-Reply-To: <dca487e823b48.4561eda4@gwu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yuichi Nakamura wrote:
> Hi, I looked at the latest policycoreutils code.
> (policycoreutils-1.33.1-9.fc7.src.rpm)
> 
> And found strange code, in setsebool.c.
> 
>     94  /* Apply (permanent) boolean changes to policy via libsemanage */
>     95  static int semanage_set_boolean_list(size_t boolcnt,
>     96                                       SELboolean * boollist, int perm)
>     97  {
>    <snip>
>    117          } else if (managed == 0) {
>    118                  if (selinux_set_boolean_list(boolcnt, boollist, 1) < 0)
>    119                          goto err;
>    120                  goto out;
>    121          }
> 
> Why 3rd arg for selinux_set_boolean_list is "1"?
> Should it be "perm"?
> 

Looks that way to me. Additionally, is it even possible to make 
non-permanent change to a boolean via semanage? If not, then this code 
path should check for that. Josh?

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
