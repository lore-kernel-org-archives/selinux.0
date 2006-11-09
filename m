Message-ID: <45538DFE.8030509@us.ibm.com>
Date: Thu, 09 Nov 2006 14:22:22 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 4/8] make newrole suid (take 3)
References: <454A8F35.2020006@us.ibm.com> <454A95BC.7000807@us.ibm.com> <20061107052338.GB11273@sergelap.austin.ibm.com> <4550E7E4.4000505@us.ibm.com> <20061108173224.GB15592@sergelap.austin.ibm.com> <45523185.40502@us.ibm.com> <20061109051513.GA7208@sergelap.austin.ibm.com> <1163080631.12241.242.camel@moss-spartans.epoch.ncsc.mil> <20061109163735.GA16709@sergelap.austin.ibm.com>
In-Reply-To: <20061109163735.GA16709@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn wrote:
> But I really don't mean to beat a dead horse.  Thank you both for the
> explanations, the patch does look sane.  (On my first reading I'd
> actually misread the prctl and thought it was going to keep caps
> across the final setuid).

So the fallout from this is: no changes need to be made to the patches?

Thanks,
Mike


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
