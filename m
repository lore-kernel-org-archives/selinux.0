Message-ID: <50081541.3040909@redhat.com>
Date: Thu, 19 Jul 2012 10:10:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ole Kliemann <ole@plastictree.net>, Russell Coker <russell@coker.com.au>,
        selinux@tycho.nsa.gov
Subject: Re: Information about XSELinux
References: <20120716161006.GA14824@telvanni>  <201207170423.14495.russell@coker.com.au> <20120716221818.GA16156@telvanni> <1342704589.31048.22.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1342704589.31048.22.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/19/2012 09:29 AM, Stephen Smalley wrote:
> On Tue, 2012-07-17 at 00:18 +0200, Ole Kliemann wrote:
>> On Tue, Jul 17, 2012 at 04:23:14AM +1000, Russell Coker wrote:
>>> On Tue, 17 Jul 2012, Ole Kliemann <ole@plastictree.net> wrote:
>>>> Is it included in any major distributions? (Currently using Ubuntu
>>>> 12.04)
>>> 
>>> Unless Ubuntu have done some significant enhancements over my Debian
>>> work without telling me then it's not going to work.
>> 
>> I'm no expert, but as far as I can tell, it's just not there in Ubuntu.
>> 
>> I understood from a bug report on this list that it's included in Fedora.
>> So I installed it on a test system and could reproduce the bug (X server
>> fails to start when xserver_object_manager is set).
>> 
>> I'm willing to switch to whatever distribution is providing the means to
>> seperate user contexts under X.
> 
> XSELinux is included in Fedora, but they don't enable it by default so it
> doesn't get much testing.  They took a different approach for isolating X
> applications via nested Xephyr servers in their sandbox tool.
> 

My opinion is that XAce or XSELinux works ok with the MLS model, but not with
the type enforcement model.  In my opinion isolating applications within the
own sandbox/containers is a simpler and more sustainable approach.

XClients that get a permission denied, are likely to misbehave (die) since
they were coded with the assumption that they either get full access to X or
no access to X.

Finally trying to write confinement policy for a type enforcement model on X
is very difficult, how do I isolate two instances of firefox?  If Firefox
execs a open office, how does this libreoffice interact with the existing
libreoffice that might be running under a different context.  How does
cut/paste work, how about one window obscuring another, transparent windows
...  Way too complicated.  Sandbox model is just total separation.  They do
not even know the other apps exist.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAIFUEACgkQrlYvE4MpobNosQCfWwKjjPONs5WHNbDGit3NYGXt
iegAn1mav7HlS21m5q89xy47pXDXpw8x
=fZVQ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
