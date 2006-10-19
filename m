Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9JLRQld020312
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 17:27:26 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9JLQgCx017094
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 21:26:43 GMT
Date: Thu, 19 Oct 2006 17:27:21 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: jbrindle@tresys.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: RE: SELinux Networking Enhancements
In-Reply-To: <000f01c6f390$3845da60$cc0a010a@tcssec.com>
Message-ID: <Pine.LNX.4.64.0610191722520.30826@d.namei>
References: <000f01c6f390$3845da60$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 19 Oct 2006, Venkat Yekkirala wrote:

> You would have just as many "secpoints" as you currently
> would "secmarks". No difference there. Same level of flexibility
> and scalability. Nothing more, nothing less.
> 
> Example:
> 
> 1. An outbound connection to port 80 on machine 10.0.0.1
> 
> SECMARK:
> -A OUTPUT -m state --state NEW -p tcp -d 10.0.0.1 --dport 80 -j
> SECMARK --selctx system_u:object_r:http_client_packet_t:s2
> 
> SECPOINT:
> -A OUTPUT -m state --state NEW -p tcp -d 10.0.0.1 --dport 80 -j
> SECMARK --selctx system_u:object_r:httpd_t:s0
> 
> Reason for the change in Type from http_client_packet_t to httpd_t:
> 
> All incoming packets on this connection would be from a web-server so should
> be carrying httpd_t as opposed to http_client_packet_t. Also, all outbound
> traffic on this connection carries the originating socket context
> (firefox_t)
> which would be flow-controlled against httpd_t.
> 
> So, just a change in semantics. Whereas you formerly had
> allow firefox_t http_client_packet_t:packet { send recv }
> 
> you would now have:
> 
> allow firefox_t httpd_t:packet { recv }
> allow firefox_t httpd_t:packet { flow_out }
> 
> For the forwarding case:
> 
> -A PREROUTING -p tcp -s 10.0.0.5  -j SECMARK --selctx
> system_u:object_r:webonly_t:s0
> 
> -A FORWARD -m state --state NEW -p tcp -d 10.0.0.1 --dport 80 -j
> SECMARK --selctx system_u:object_r:httpd_t:s0
> -A PREROUTING -p tcp -s 10.0.0.1 --sport 80 -j SECMARK --selctx
> system_u:object_r:httpd_t:s0
> (can also use CONNSECMARK to save from FORWARD and restore it at PREROUTING
> to label all traffic back from
> the webserver)
> 
> allow webonly_t httpd_t:packet { flow_out }
> allow httpd_t webonly_t:packet { flow_out }
> 
> I have only given the main rules and there are ofcourse other supporting
> rules required
> to get things going.

This is too complicated, most people will not understand it.  I think it's 
also a security risk, because of the complexity of composing these 
labeling mechanisms and the chance that mistakes will be made in 
deployment, as well as scaring people away from using the technology 
altogether.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
