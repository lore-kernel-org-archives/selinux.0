Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pA248CDf018092
	for <selinux@tycho.nsa.gov>; Wed, 2 Nov 2011 00:08:12 -0400
Received: from exprod8og113.obsmtp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pA248BlN008183
	for <selinux@tycho.nsa.gov>; Wed, 2 Nov 2011 04:08:11 GMT
Received: by iahk25 with SMTP id k25so10803963iah.12
        for <selinux@tycho.nsa.gov>; Tue, 01 Nov 2011 21:08:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E9589F9.3090006@redhat.com>
References: <CAC9ii1q_EKnM+akoiApESQfcERYKOx+nxX7iurVPbmrgrvd2Cg@mail.gmail.com>
 <4E9589F9.3090006@redhat.com>
From: Jason Axelson <jaxelson@referentia.com>
Date: Tue, 1 Nov 2011 18:07:49 -1000
Message-ID: <CAC9ii1pMkekO0e-vj4iYD3m5CRAB3d+3c5TcVaSS_KKeO_4geg@mail.gmail.com>
Subject: Re: Writing a program to monitor the SELinux log
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 12, 2011 at 2:37 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> On 10/11/2011 11:07 PM, Jason Axelson wrote:
>> Hi,
>>
>> I am writing a program that will monitor the SELinux log for AVC
>> violations and deal with them appropriately. Currently I am looking
>> at approaches to monitor the SELinux log.
>>
>> One approach is to do raw monitoring of /var/log/audit/audit.log
>> with something like: tail -f /var/log/audit/audit.log | ausearch -m
>> avc
>>
>> A second approach may be to implement an SETroubleShoot plugin:
>> https://fedorahosted.org/setroubleshoot/wiki/SETroubleShoot%20Overview
>>
>>  I'm kind of leaning towards an SETroubleShoot plugin since it
>> seems like less new development and the infrastructure seems to be
>> already there.
>>
>> Is this a valid approach? Is there a better way?
>>
> I would say either just write an setroubleshoot plugin or copy the
> code in sedispatch from setroubleshoot to build your own audit
> dispatcher, that watches for SELinux messages.

Thanks for all of the suggestions!

After some consideration I think I will either copy sedispatch or
write my own version of sedispacth (it's only 266 lines after all!).
This was mainly chosen because it is simple, performant, and doesn't
bring in unnecessary dependencies.

Thanks,
Jason


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
