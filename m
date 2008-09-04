Message-ID: <48BFEC01.3080603@manicmethod.com>
Date: Thu, 04 Sep 2008 10:09:05 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Vikram Noel Ambrose <noel.ambrose@gmail.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Manoj Srivastava <srivasta@debian.org>, Caleb Case <ccase@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH][origin/autotools] fix libtool_compat header error
References: <48B6FD13.1000204@windriver.com> <48BF4023.7010007@manicmethod.com> <48BF5551.5080702@gmail.com>
In-Reply-To: <48BF5551.5080702@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vikram Noel Ambrose wrote:
> Joshua Brindle wrote:
>> Vikram Ambrose wrote:
<snip> 
> Oh before i forget. It would be nice to add NEWS, README and AUTHORS
> files to each package folder, no mandatory, but would make life easier,
> as these files need to be generated before autoconf can be run, and it
> would be better to have meaningful content for these files then stubbing
> it out on the fly from the autogen.sh script. If there is no objection I
> will create a separate commit for these files.
> 

I removed them from the previous patch because they were incomplete and may have been seen as offensive to some (eg., the AUTHORS file only had you and I listed). There are quite a few contributors to this code and I'm not even sure if I could collect them all. Steve might be able to though, since he has some sort of bionic brain.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
