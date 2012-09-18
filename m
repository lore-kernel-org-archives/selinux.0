Message-ID: <5058B5B9.5090409@tresys.com>
Date: Tue, 18 Sep 2012 13:56:09 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>, William Roberts <bill.c.roberts@gmail.com>,
        Joman
 Chu <jcchu@tycho.ncsc.mil>
Subject: Re: seandroid and policy version
References: <4FFCC3C7.8080602@tresys.com>  <1342011045.29461.28.camel@moss-pluto.epoch.ncsc.mil>  <4FFDD7C7.4020703@tresys.com>  <1342036191.29461.75.camel@moss-pluto.epoch.ncsc.mil>  <1347989611.31966.66.camel@moss-pluto.epoch.ncsc.mil>  <5058B22B.2020301@tresys.com> <1347990196.31966.70.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1347990196.31966.70.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2012-09-18 at 13:40 -0400, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Wed, 2012-07-11 at 15:49 -0400, Stephen Smalley wrote:
>> <snip>
>>> So this issue has come up again in the context of implementing device
>>> admin APIs and a sample device admin app.  The device admin API
>>> implementation in the system_server needs to know how to name the file
>>> it creates under /data/system for the kernel policy, but it has no way
>>> to determine the actual policy version of the supplied policy.  So it
>>> doesn't know what suffix to use.  Options:
>>> - Get rid of the version suffix altogether, or at least for the sepolicy
>>> file under /data/system.
>>> - Have the system_server parse the header of the policy image to
>>> determine the policy version, and use that as the suffix.
>>>
>>> Thoughts?
>>>
>> Can the MDM server not provide the device admin API with the correct
>> filename to use? How are you feeding the policy to the API?
>
> At the moment it is being passed directly as a byte array (similar to
> security_load_policy).  Passing by pathname would require that the
> system_server have read/search access to a private file created by the
> device admin app, and passing by open fd would require that the device
> admin app first write the policy image to local storage before passing
> it to the system_server.  So passing it directly seems preferable.
>

I assumed byte array but is the API going to basically be "here's your 
policy blob" and the system_server has to figure out what to do with it? 
I strongly believe that we will outgrow an API like that very quickly. 
MDM vendors want to do some interesting things and always doing it on 
the server side isn't going to be feasible I think (holding >10k SELinux 
policies in order to update them when new 
containers/apps/features/whatever are added is not ideal).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
