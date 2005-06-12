Message-ID: <20050612175030.99422.qmail@web31601.mail.mud.yahoo.com>
Date: Sun, 12 Jun 2005 10:50:29 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Question about integration of IPsec with SELinux? 
To: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20050612021611.94597.qmail@web51501.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Park Lee <parklee_sel@yahoo.com> wrote:
 
> ... Is there any other way to send security
> attribute
> first and then the date (just like in IPsec case)
> except using IPsec?

CIPSO provides sufficient mechanism to do this.
There are also the TSIG TSIX protocols, but I
seriously doubt you'd want to invest heavily in
those with IPSEC around.



Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Discover Yahoo! 
Find restaurants, movies, travel and more fun for the weekend. Check it out! 
http://discover.yahoo.com/weekend.html 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
