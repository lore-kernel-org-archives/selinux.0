Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k920K9ki029253
	for <selinux@tycho.nsa.gov>; Sun, 1 Oct 2006 20:20:09 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k920JVYw015424
	for <selinux@tycho.nsa.gov>; Mon, 2 Oct 2006 00:19:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
Subject: Re: 'chcon': possible weakness
Date: Mon, 2 Oct 2006 10:20:12 +1000
Cc: selinux@tycho.nsa.gov
References: <BAY114-F2E3CC85812D9DF59FB8D2AF1E0@phx.gbl>
In-Reply-To: <BAY114-F2E3CC85812D9DF59FB8D2AF1E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610021020.14310.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 02 October 2006 08:59, "Salvo Giuffrida" <giuffsalvo@hotmail.it> 
wrote:
> I found in the FC5 targeted policy that httpd_t has execute access on files
> of type bin_t...Isn't this an huge security hole? Couldn't one who exploit
> an httpd weakness execute 'chcon' (which has security attributes rwxr-xr-x
> root root system_u:object_r:bin_t), and change the Security Context of a
> file he wants access to?

Sure they can execute chcon, but they can only change context in accordance 
with policy.

Having chcon with type bin_t is no more a security issue than having chmod 
with mode 0755 in the Unix permissions system.  You can run the program 
without limits, but what operations that program will be capable of are very 
limited.

Do an experiment by running a shell as httpd_t and try execing chcon and see 
what you can do.  Or use "apol" to analyse the policy and see what relabelto 
and relabelfrom operations are permitted.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
