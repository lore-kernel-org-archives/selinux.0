Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9M5tJ3M028484
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 01:55:19 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9M5sP5V018608
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 05:54:25 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n9M5nLR9026034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 00:49:22 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n9M5lZiI024564
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 00:47:36 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: 'make policy' issues
References: <4ADF2358.4050606@laganowski.net>
	<1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>
	<4ADF2663.2030105@laganowski.net>
	<1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil>
	<87hbtsvhru.fsf@anzu.internal.golden-gryphon.com>
	<4ADF3D2C.2030408@laganowski.net>
Date: Thu, 22 Oct 2009 00:47:35 -0500
In-Reply-To: <4ADF3D2C.2030408@laganowski.net> (Eric Laganowski's message of
	"Wed, 21 Oct 2009 12:56:12 -0400")
Message-ID: <87oco0c748.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 21 2009, Eric Laganowski wrote:

> Manoj Srivastava wrote:
>> On Wed, Oct 21 2009, Stephen Smalley wrote:
>>   
>>>> Re flex: What is the requirement for flex from selinux
>>>> perspective? Is it known what build of flex is "known good"?
>>>>       
>>> My impression is that one of the patches carried by the distributions
>>> for flex is needed for checkpolicy to work, but no one has ever fully
>>> investigated the precise dependency - people just grab the Fedora srpm
>>> and apply those patches to flex, and then rebuild checkpolicy and it
>>> works.  I haven't seen any complaints from Debian or Gentoo so I presume
>>> that they also carry the same patches for flex.
>>>
>>> flex -V here also shows 2.5.35.  But there are three patches in the
>>> Fedora package.  Attached.
>>>     
>>
>>         Debian currently carries 13 (though 3 of them need to be
>>  squashed together) patches against 2.5.35. I can make them available if
>>  there is interest.
>>
>>         manoj
>>   
> Yes please. Patches would be welcome.

        ok. I have put all the patches at:
 http://www.golden-gryphon.com/software/misc/flex-patches/

        If you want to browse the git repository and see which topic
 branches these patches come from, you may browse the repo at:
   http://git.debian.org/?p=users/srivasta/debian/flex.git

        The upstream sources are in the upstream branch, and the various
 topic--[!old]foo branches are feature branches, and master is the
 integration branch that Debian packages are built from.

        I hope this helps.

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
