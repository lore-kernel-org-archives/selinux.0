Subject: Re: ipsec and getpeercon()
From: Joshua Brindle <jbrindle@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Joy Latten <latten@austin.ibm.com>, latten@us.ibm.com,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov
In-Reply-To: <200609050000.10205.paul.moore@hp.com>
References: <36282A1733C57546BE392885C061859201512DD1@chaos.tcs.tcs-sec.com>
	 <44F8B50E.3060303@hp.com>
	 <1157395888.10620.2.camel@twoface.columbia.tresys.com>
	 <200609050000.10205.paul.moore@hp.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 07:53:24 -0400
Message-Id: <1157457204.15886.7.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-05 at 00:00 -0400, Paul Moore wrote:
> On Monday 04 September 2006 2:51 pm, Joshua Brindle wrote:
> > On Fri, 2006-09-01 at 18:32 -0400, Paul Moore wrote:
> > > Paul Moore wrote:
> > > > Venkat Yekkirala wrote:
> > > >>>Unfortunately, the fix
> > > >>>is not immediately obvious.
> > > >>
> > > >>You would use the xfrm_sid and in it's absence the node
> > > >>sid as the base sid.
> > > >
> > > > That is not the issue I am dealing with right now.
> > > >
> > > > I now have a solution in mind, however, it is doubtful I will have a
> > > > chance to do any sort of testing on it before I leave tonight.  Once I
> > > > can give it a quick test to verify that it doesn't break anything I'll
> > > > post a patch for you and Joy to verify.
> > >
> > > Sorry for attaching the patch as an attachment but I'm in a rush to get
> > > out of here ...
> > >
> > > This patch is against David Miller's net-2.6.19 tree from a day or two
> > > ago, depending on your kernel you may have some fuzz when applying this
> > > patch.  I've only done some quick functional tests, but it seems to
> > > solve this problem.
> > >
> > > Joy, Venkat if you are able to test this and let me know the results I
> > > would appreciate it.
> > >
> > > Thanks.
> >
> > I tried the (rebased patch below, there were some rejects when applying
> > it to todays net-2.6.19) and got the same behavior as before:
> >
> > [root@joker-rawhide-clone ~]# ./server
> > server: got connection from 10.1.13.104, root:system_r:unconfined_t:s0
> >
> > [root@joker-rawhide-clone ~]# runcon -t passwd_t ./server
> > server: got connection from 10.1.13.104, root:system_r:passwd_t:s0
> 
> Thanks for giving the patch a try.  I'm confused as to why it didn't work for 
> you, can you try it without IPsec configured to see what results you get 
> (that is what I did and it worked fine)?
> 
> Thanks.

Or it could just be that I'm retarded and booted up on the wrong kernel
after cloning the VM. The new results (with no SAD or SPD entries) is a
nice "Protocol not available" on both sides. With the entries I now get 

server: got connection from 10.1.13.104, system_u:object_r:unlabeled_t

which is the correct label of the local ipsec socket (changed it to make
sure it was getting the local context) which still isn't what I'd expect
getpeercon() to tell me.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
