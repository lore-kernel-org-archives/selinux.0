Subject: Re: port and address caches
From: Joy Latten <latten@austin.ibm.com>
To: James Morris <jmorris@redhat.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <Xine.LNX.4.44.0507121533180.4276-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0507121533180.4276-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 16:16:25 -0500
Message-Id: <1121202985.4518.10.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-07-12 at 15:34 -0400, James Morris wrote:
> On Tue, 12 Jul 2005, Joy Latten wrote:
> 
> > indicate some performance improvement. I am currently working 
> > on a testcase that will somewhat exercise the use of ports and/or
> > ipaddresses. Hopefully this will better indicate an improvement.
> 
> apachebench can give you a very quick and simple view of the network 
> overhead.
> 
> 
> - James
> -- 
> James Morris
> <jmorris@redhat.com>
> 
> 
>  with ESMTP id j6CJYNV11668;
> 	Tue, 12 Jul 2005 15:34:23 -0400
> Received: from thoron.boston.redhat.com (thoron.boston.redhat.com [172.16.80.63])
> 	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6CJYAg2019690;
> 	Tue, 12 Jul 2005 15:34:23 -0400
> Date: Tue, 12 Jul 2005 15:34:10 -0400 (EDT)
> From: James Morris <jmorris@redhat.com>
> X-X-Sender: jmorris@thoron.boston.redhat.com
> To: Joy Latten <latten@austin.ibm.com>
> cc: SELinux@tycho.nsa.gov
> Subject: Re: port and address caches
> In-Reply-To: <200507121746.j6CHkePX004477@faith.austin.ibm.com>
> Message-ID: <Xine.LNX.4.44.0507121533180.4276-100000@thoron.boston.redhat.com>
> MIME-Version: 1.0
> Content-Type: TEXT/PLAIN; charset=US-ASCII
> Sender: owner-selinux@tycho.nsa.gov
> Precedence: bulk
> X-Mailing-List: selinux-tycho.nsa.gov
> Status: O
> 
> On Tue, 12 Jul 2005, Joy Latten wrote:
> 
> > indicate some performance improvement. I am currently working 
> > on a testcase that will somewhat exercise the use of ports and/or
> > ipaddresses. Hopefully this will better indicate an improvement.
> 
> apachebench can give you a very quick and simple view of the network 
> overhead.
> 
> 
> - James

Ok, thanks! I will give it a try.

Regards,
Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
