Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3OKctqA010938
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 16:38:55 -0400
Received: from nz-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3OKcsJc000586
	for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 20:38:54 GMT
Received: by nz-out-0506.google.com with SMTP id n1so1754535nzf
        for <selinux@tycho.nsa.gov>; Tue, 24 Apr 2007 13:38:54 -0700 (PDT)
Message-ID: <462E6ADC.7010802@gmail.com>
Date: Tue, 24 Apr 2007 15:38:52 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: adding to selinux.py
References: <462CAF84.20708@gmail.com> <1177337371.24282.8.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1177337371.24282.8.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2007-04-23 at 08:07 -0500, Ted X Toth wrote:
>   
>> Would it be possible to get get_ordered_context_list and get_default_context* added to selinux.py?
>>     
>
> selinux.py is generated via swig, so you'd actually want to modify
> selinuxswig.i and regenerate it.   And I think selinuxswig.i should be
> reworked and split along the lines of semanageswig.i and
> semanageswig_python.i over in libsemanage.
>
>   
Is this something that I should look at doing or will Dan be doing it? 
Should I open a bug report?

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
