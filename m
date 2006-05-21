From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <method@gentoo.org>
Subject: Re: Real simple cache that removes most of the lookups in mcstrans
Date: Sun, 21 May 2006 13:31:03 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <446AFED3.9010800@redhat.com> <1148047642.25168.107.camel@moss-spartans.epoch.ncsc.mil> <446F8E7C.8010503@gentoo.org>
In-Reply-To: <446F8E7C.8010503@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605211331.09223.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 21 May 2006 07:47, Joshua Brindle <method@gentoo.org> wrote:
> a file that a program read, only further access to the file. And I know
> that the client can cache the information outside of the library. My
> point is that if the access changes the client potentially won't know
> because the library is transparently caching the information and not
> consulting the server.

That depends on the client.  I believe that the operation of ls will not 
become any less correct in the face of translation caching and changes to 
translations during the run-time of ls.  Having a listing of files in a 
directory (or tree) that is translated in different ways is not a good 
result, the only way for ls to have a consistent result in such situations is 
to have more caching such that a translation will never change for the 
duration of the process!

> Understood, however, if the client is providing a translation service
> for a user (or other application) it should get notification if that
> user/app should no longer be able to see the translation, right? The
> translations are treated like objects in this scheme, unless I'm
> misunderstanding something.

That might be suitable for some programs, but is not required for ls or ps.

What if we have a cache that defaults to on but which can be turned off on 
demand by programs that have special requirements in that regard?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
