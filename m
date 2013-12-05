Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rB5Jvbpa030609
	for <selinux@tycho.nsa.gov>; Thu, 5 Dec 2013 14:57:37 -0500
Message-ID: <1386273455.65331.YahooMailNeo@web163402.mail.gq1.yahoo.com>
Date: Thu, 5 Dec 2013 11:57:35 -0800 (PST)
From: Andy Ruch <adruch2002@yahoo.com>
Reply-To: Andy Ruch <adruch2002@yahoo.com>
Subject: Information flow paths over devtty_t
To: SELinux ML <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="303371348-1736189734-1386273455=:65331"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--303371348-1736189734-1386273455=:65331
Content-Type: text/plain; charset=us-ascii

I'm implementing a strict SELinux policy based on the reference policy using RHEL 6.3. Using 'apol' to analyze my information flow paths, I've been able to eliminate most of the tty/console paths. However, I can't seem to find a way to eliminate the access to the controlling terminal devtty_t. 


I see that this is allowed in domain.te:

# Use trusted objects in /dev
dev_rw_null(domain)
dev_rw_zero(domain)
term_use_controlling_term(domain)


Is devtty_t something I should be concerned about? Is this a type that can be used to share information between processes or is it special like /dev/null and /dev/zero?

Thanks,
Andrew

--303371348-1736189734-1386273455=:65331
Content-Type: text/html; charset=us-ascii

<html><body><div style="color:#000; background-color:#fff; font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;font-size:12pt"><div>I'm implementing a strict SELinux policy based on the reference policy using RHEL 6.3. Using 'apol' to analyze my information flow paths, I've been able to eliminate most of the tty/console paths. However, I can't seem to find a way to eliminate the access to the controlling terminal devtty_t. <br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: HelveticaNeue,Helvetica Neue,Helvetica,Arial,Lucida Grande,sans-serif; background-color: transparent; font-style: normal;"><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: HelveticaNeue,Helvetica Neue,Helvetica,Arial,Lucida Grande,sans-serif; background-color: transparent; font-style: normal;">I see that this is allowed in domain.te:</div><div><br></div><div style="color: rgb(0, 0, 0); font-size: 16px;
 font-family: HelveticaNeue,Helvetica Neue,Helvetica,Arial,Lucida Grande,sans-serif; background-color: transparent; font-style: normal;"># Use trusted objects in /dev<br>dev_rw_null(domain)<br>dev_rw_zero(domain)<br>term_use_controlling_term(domain)</div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: HelveticaNeue,Helvetica Neue,Helvetica,Arial,Lucida Grande,sans-serif; background-color: transparent; font-style: normal;"><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: HelveticaNeue,Helvetica Neue,Helvetica,Arial,Lucida Grande,sans-serif; background-color: transparent; font-style: normal;"><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: HelveticaNeue,Helvetica Neue,Helvetica,Arial,Lucida Grande,sans-serif; background-color: transparent; font-style: normal;">Is devtty_t something I should be concerned about? Is this a type that can be used to share information between processes or is it
 special like /dev/null and /dev/zero?</div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: HelveticaNeue,Helvetica Neue,Helvetica,Arial,Lucida Grande,sans-serif; background-color: transparent; font-style: normal;"><br></div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: HelveticaNeue,Helvetica Neue,Helvetica,Arial,Lucida Grande,sans-serif; background-color: transparent; font-style: normal;">Thanks,</div><div style="color: rgb(0, 0, 0); font-size: 16px; font-family: HelveticaNeue,Helvetica Neue,Helvetica,Arial,Lucida Grande,sans-serif; background-color: transparent; font-style: normal;">Andrew<br></div></div></body></html>
--303371348-1736189734-1386273455=:65331--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
