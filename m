Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l77Dp9ji024923
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 09:51:09 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l77Dp8mT015492
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2007 13:51:08 GMT
Message-ID: <46B877E5.6030002@redhat.com>
Date: Tue, 07 Aug 2007 09:47:17 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Application_domain
References: <46B1F9CD.5070202@redhat.com> <1186491980.18881.15.camel@gorn>
In-Reply-To: <1186491980.18881.15.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2007-08-02 at 11:35 -0400, Daniel J Walsh wrote:
>   
>> My definition of the application domain, is any file that a normal
>> user is expected to execute.   It can either have a  transition or
>> not.  If I define application_domain then it will transition.  If I
>> just define application_executable_file, then logged in users can
>> execute it without a transition.
>>
>> Daemons for the most part should NOT be application_domains.   This
>> way we can dontaudit getattr of daemons that users would/should not be
>> allowed to execute.
>>
>> Some applictions can be in both domains.  For example cvs, rsync can
>> be run without transitioning by users but when run from an initscript
>> they transition.
>>
>> This patch makes changes to the pool to match this.
>>     
>
> If you look back at what you're changing, init_system_domains() are all
> apps, so the call is in that interface.  Your patch undoes this.
>
>   
Ok I guess your right, even though some of these being user executables 
is a little shaky.

Reverting patch in rawhide.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
