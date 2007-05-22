Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4MG0ple021953
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 12:00:52 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l4MG0l61022914
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 16:00:47 GMT
Message-ID: <46531381.6050101@manicmethod.com>
Date: Tue, 22 May 2007 12:00:01 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>
CC: Klaus Weidner <klaus@atsec.com>, James Antill <jantill@redhat.com>,
        Paul Moore <paul.moore@hp.com>, SE Linux <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Fedora Core 7 has frozen and Fedora 8 Development has started
References: <464E13CB.1070609@redhat.com> <20070521190811.GA11544@w-m-p.com> <4651EFCC.1040500@redhat.com> <200705211543.10171.paul.moore@hp.com> <1179779222.23650.24.camel@code.and.org> <20070521221304.GB11544@w-m-p.com> <4652F0B7.60506@manicmethod.com> <6FE441CD9F0C0C479F2D88F959B01588BEFCC2@exchange.columbia.tresys.com> <465308DD.2090600@manicmethod.com> <6FE441CD9F0C0C479F2D88F959B01588BEFCD4@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BEFCD4@exchange.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd Miller wrote:
> Joshua Brindle wrote:
>   
>> What does allowable file context mean?
>>
>> You need to be able to do an analysis on the policy to see what user
>> can relabelfrom and what they can relabelto. If they can't
>> relabelfrom the file being modified in nautilus then nothing should
>> appear, otherwise the types they can relabelto would appear.   
>>     
>
> A security_get_file_sids() function was added to the security server
> that takes a usersid and a class (was always SECLASS_FILE) and returns a
> list of sids that the user has relabelto permissions.  It was probably
> not really sufficient for the task as it doesn't take relabelfrom into
> account (it predates any hacking I did on SEDarwin, though I did stop it
> from panicing).
>
> The kernel code in question is still online at:
> http://sedarwin.org/cgi-bin/cvsweb/sedarwin8/policies/sedarwin/sedarwin/
> ss/services.c
>   
it also ignores other parts of a context so it isn't really sufficient, 
if the type can be relabeledfrom and to but the user is different a 
contraint will prevent the relabel, for example. It also doesn't take 
any mls/mcs into account.

I also think it isn't appropriate to do analysis of the policy in the 
kernel, a better alternative might be to make a kernel interface to 
output the policydb that an apol-like daemon could read and perform 
queries on when requested.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
