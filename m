Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBBHYFfW025394
 for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2015 12:34:18 -0500
Received: by mail-ig0-f178.google.com with SMTP id ph11so43260938igc.1
 for <selinux@tycho.nsa.gov>; Fri, 11 Dec 2015 09:34:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9ff3d27dab814859add817e00b6963b5@VNUCITEX02.ICFI.icfconsulting.com>
References: <CAEuTsAwvF6MnFsGi65Hk3nrF1dciCB40FQ64=gRF7wqpQG-r7A@mail.gmail.com>
 <56522b0c4e554eddbeebf7e6c34c5e1b@VNUCITEX02.ICFI.icfconsulting.com>
 <CAEuTsAwOkM7icjryr03g_3Qi1BEUGM31WdMFkjZEQq5ELsV0BA@mail.gmail.com>
 <9ff3d27dab814859add817e00b6963b5@VNUCITEX02.ICFI.icfconsulting.com>
From: David Li <dlipubkey@gmail.com>
Date: Fri, 11 Dec 2015 09:33:48 -0800
Message-ID: <CAEuTsAw2wOW+Xj08sZRXdFUyr4zyCNhruqksBxVX3ohMuf1iAg@mail.gmail.com>
Subject: Re: A newbie's question
To: "Higgs, Stephen" <Stephen.Higgs@icfi.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Stephen,

My goal is to study how to use SElinux policy for an application
running on Centos. My approach is to build everything into one single
RPM for easy installation/upgrade/change. This includes both the ref
policy and application policy. I started out by building the RPM with
only ref policy. I will add in app policy after I make sure this RPM
works well.

David


On Fri, Dec 11, 2015 at 9:07 AM, Higgs, Stephen <Stephen.Higgs@icfi.com> wrote:
> I have not installed the ref policy for CentOS, but consider that SELinux policy modules are a great avenue to customize your system.  Maybe you should tell us what you are trying to achieve?
>
> --Stephen
>
>
>> -----Original Message-----
>> From: David Li [mailto:dlipubkey@gmail.com]
>> Sent: Friday, December 11, 2015 11:31 AM
>> To: Higgs, Stephen
>> Cc: selinux@tycho.nsa.gov
>> Subject: Re: A newbie's question
>>
>> Hi Stephen,
>>
>> If I install my own ref policy RPM on the Centos7 box, would that
>> replace the existing or stock ref policy?
>>
>> David
>>
>> On Tue, Dec 8, 2015 at 10:48 AM, Higgs, Stephen <Stephen.Higgs@icfi.com>
>> wrote:
>> >> -----Original Message-----
>> >> From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of
>> >> David Li
>> >> Sent: Tuesday, December 08, 2015 1:29 PM
>> >> To: selinux@tycho.nsa.gov
>> >> Subject: A newbie's question
>> >>
>> >> Hi,
>> >>
>> >> I thought I would post this question here in addition to the Fedora
>> >> list to get more help.
>> >>
>> >> ----
>> >>
>> >> Maybe this is just for my own clarifications; I am about to start
>> >> SELinux learning and development.  I have a stock Cento 7.1 install
>> >> and I am curious what''s difference between the following two:
>> >>
>> >> 1. Enable SElinux and setenforce 1 on the stock install
>> >>
>> >> vs.
>> >>
>> >> 2. Build a reference policy RPM and install it on the box. Then do
>> >> step
>> >> 1 as above.
>> >>
>> >> Are there any differences in terms of ref policy? Would step 1 also
>> >> have the ref policy enabled by default too?
>> >>
>> >> Thanks.
>> >> _______________________________________________
>> >> Selinux mailing list
>> >> Selinux@tycho.nsa.gov
>> >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> >> To get help, send an email containing "help" to Selinux-
>> >> request@tycho.nsa.gov.
>> >
>> > CentOS 7.1 has the reference policy installed, but there could be a
>> difference in version of the RPM reference policy and the version that
>> is current for 7.1.
>> >
>> > The seinfo command is one way to show what is currently installed.
>> >
>> > --Stephen
>> >
