Message-ID: <49B84487.5080900@tycho.nsa.gov>
Date: Wed, 11 Mar 2009 19:08:55 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, ajax@redhat.com,
        method@manicmethod.com, joe@nall.com, txtoth@gmail.com
Subject: Re: [PATCH -v2] libselinux: cache avc_compute_create results in the
 avc
References: <1236710286.20019.7.camel@localhost.localdomain> <49B70919.7030504@tycho.nsa.gov>
In-Reply-To: <49B70919.7030504@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Eric Paris wrote:
>   
>> In one benchmark the X server was found to be extremely slow creating
>> windows with selinux running.  Part of the reason for this was because
>> libselinux called into the kernel /selinux/create interface for every
>> object.  This patch caches the results of /selinux/create in the
>> userspace avc to significantly increase the speed of these types of
>> operations.
>>
>> Signed-off-by: Eric Paris <eparis@redhat.com>
>>   
>>     
>
> There's some sloppy locking going on in avc_compute_create(), and I
> don't think I want the ADD_CREATE command exposed in the header file,
> since it's just an internal caching operation, not an external stimuli
> like a revoke or reset.  But I'll fix these 2 things up myself and push
> it tomorrow, along with ajax's socket handoff patches.  Thanks for doing
> this.
>   

Pushed to libselinux 2.0.79.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
