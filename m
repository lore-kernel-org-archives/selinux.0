Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k21ECJfk015246
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 09:12:19 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k21EAm1o009767
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 14:10:49 GMT
Subject: Re: FYI SELinux/AppArmor press
From: Erich Schubert <erich@debian.org>
To: cwarner <cwarner@kernelcode.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1141183226.8475.22.camel@localhost.localdomain>
References: <43FF7418.90205@redhat.com>
	 <1141138934.29803.2.camel@wintermute.xmldesign.de>
	 <1141183226.8475.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 01 Mar 2006 15:12:17 +0100
Message-Id: <1141222338.2834.33.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Christopher,
Well, I'm still not running SELinux reference policy successfully.
So anything that actually works is easier to use...
E.g. if the reference policy would include a users_extra file that
labels /root
with sysadm prefix... and if that were documented anywhere and wouldn't
have required me to dive through the source of three packages.
Now if ssh login as sysadm_r would work, I'd be mostly done.

Albeit the documented interfaces of current RefPolicy are an
improvement, I don't think that policy writing has become much easier.
The M4 syntax is still very awkward (backticks, no semicolons), and
unless you've read all the policy thoroughly (e.g. because you've
written it), you'll have a hard time finding the right macros to call.
It's also very unintuitive when to use a macro/call an interface and
when not.
The current policy language is still very much "bottom up", i.e. "these
is our output, how can we generate it a bit easier", and not "top down",
i.e. "this is how we want to write the policy, how do we get a useful
output".

> How is AppArmor easier to use? Negating the fact that I would have to
> learn something new.

I've never looked at AppArmor, I've been using "old" strict SELinux for
some time, so I'd prefer to get the "new" modular SELinux work... I had
experimented with grctl1 ACL some time, which I guess are similar to
what AppArmor does. And I've seen the benefits of labeled processes and
transitions, so I'd like to stick with them.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
   There was never a good war or a bad peace. - Benjamin Franklin   //\
           Ein schöner Moment leuchtet das Leben hindurch.          V_/_



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
