Message-ID: <51015943.7050606@tycho.nsa.gov>
Date: Thu, 24 Jan 2013 10:54:43 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serge@hallyn.com>
CC: Jan Stancek <jstancek@redhat.com>, selinux@tycho.nsa.gov,
        jburke@redhat.com
Subject: Re: [selinux-testsuite][PATCH] use extfs ioctls only when running
 on ext[234]
References: <2101640213.3126557.1358959802946.JavaMail.root@redhat.com> <51002308.3050709@tycho.nsa.gov> <20130124043604.GA13239@mail.hallyn.com>
In-Reply-To: <20130124043604.GA13239@mail.hallyn.com>
Content-Type: multipart/mixed;
 boundary="------------090408030104050909050409"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090408030104050909050409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 01/23/2013 11:36 PM, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
>> Odd, I have the following diff locally.
>
> Hi,
>
> is there any commit message or author attribution for the diff, so I
> can apply it to the testsuite?




--------------090408030104050909050409
Content-Type: text/x-patch;
 name="0001-Ensure-that-the-ioctl-tests-do-not-fail-on-other-fil.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Ensure-that-the-ioctl-tests-do-not-fail-on-other-fil.pa";
 filename*1="tch"


--------------090408030104050909050409--
