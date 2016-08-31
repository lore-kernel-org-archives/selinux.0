Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7VApVwn001185
 for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2016 06:51:31 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01053824
 for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2016 10:51:29 +0000 (UTC)
Received: from [10.40.2.196] ([10.40.2.196])
 by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 u7VApSL5031943
 for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2016 06:51:28 -0400
Subject: Re: Creating a new port type
To: selinux@tycho.nsa.gov
References: <578825cb-5d96-1d51-c89e-40d7ee5cad03@gmail.com>
From: Lukas Vrabec <lvrabec@redhat.com>
Message-ID: <efaaf380-5195-8d8f-9555-21bc6bf87663@redhat.com>
Date: Wed, 31 Aug 2016 12:51:27 +0200
MIME-Version: 1.0
In-Reply-To: <578825cb-5d96-1d51-c89e-40d7ee5cad03@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi Ian,

Blog by Dan Walsh will helps you.

http://danwalsh.livejournal.com/10607.html

Lukas.


On 08/30/2016 11:46 PM, Ian Pilcher wrote:
> I am attempting to write my first SELinux policy module (for the
> Logitech Media Server/squeezeboxserver).  I would like to add a new
> port type (slim_devices_port_t) for TCP and UDP 3483.
>
> I haven't been able to find an example of how to do this, except for
> stunnel.te, and the comments in that file don't lead me to believe that
> it is the right way to do things.
>
> Any pointers to examples or documentation would be appreciated.
>
> Thanks!
>


-- 
Lukas Vrabec
SELinux Solutions
Red Hat, Inc.
