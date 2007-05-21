Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4LJFgAN015895
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 15:15:42 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4LJFe9R013765
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 19:15:40 GMT
Message-ID: <4651EFCC.1040500@redhat.com>
Date: Mon, 21 May 2007 15:15:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Klaus Weidner <klaus@atsec.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Fedora Core 7 has frozen and Fedora 8 Development has started
References: <464E13CB.1070609@redhat.com> <20070521190811.GA11544@w-m-p.com>
In-Reply-To: <20070521190811.GA11544@w-m-p.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Klaus Weidner wrote:
> On Fri, May 18, 2007 at 04:59:55PM -0400, Daniel J Walsh wrote:
>   
>> This is a good time to get experimental code/updates into the rawhide 
>> stream. 
>>     
> [...]
>   
>> Others???
>>     
>
> I haven't seen MCS mentioned much recently, is anyone working on that at
> this time? Back at the 2006 SELinux symposium there were plans to
> integrate category support in file managers and maybe other user tools,
> to make it more suitable for everyday use by non-experts.
>
> -Klaus
>   
We switched to using the entire context.  There has been some arguments 
over the value of
MCS versus better support for Type Enforcement in general.  Nautilus for 
example, now can display the security context of files and allows you to 
modify it.

We would like to be able to add support for "types" in mailers, 
editors(ooffice), and other tools.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
