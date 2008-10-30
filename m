Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9U5cX6A011877
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 01:38:33 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9U5cSA0024727
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2008 05:38:33 GMT
Message-ID: <4909483E.3030306@redhat.com>
Date: Thu, 30 Oct 2008 15:38:06 +1000
From: Murray McAllister <mmcallis@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: user guide draft: "Examples: Booleans for NFS"
References: <4905320C.4090807@redhat.com> <49085722.7010901@redhat.com> <4908F1AA.9060006@redhat.com> <200810301525.19737.russell@coker.com.au>
In-Reply-To: <200810301525.19737.russell@coker.com.au>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Thursday 30 October 2008 10:28, Murray McAllister <mmcallis@redhat.com> 
> wrote:
>> These Booleans exist in SELinux policy as shipped with Fedora 10. They
>> may not exist in policy shipped with other versions of Fedora or other
>> operating systems.
>>
>> I'll keep these things in mind when the guide is forked for Red Hat
>> Enterprise Linux.
> 
> Given that M4 knowledge is required for anyone who does anything serious with 
> SE Linux, maybe you should write your documentation in M4.
At the moment the guide is for people who don't want to do anything too 
serious.
> 
> Some years ago I wrote my CV in M4 and had it produce about 10 different 
> versions (I also had a Makefile).  Then it a recruiting agent wanted a 
> version of my CV that emphasised my C coding experience I could just send the 
> relevant file.
> 
> The same technique could be used for any other document.  It would be good if 
> you could type "make" and produce documents for several versions of Fedora 
> and a couple of versions of RHEL at the same time.
> 
Our publishing tool, Publican[1], allows conditional tags, so all of the 
content could be one book, then make different versions using "make 
CONDITIONAL="fedora" and "make CONDITIONAL="rhel".

Thanks for the idea.

[1] <https://fedorahosted.org/publican>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
