Message-ID: <43BABCA7.2040309@cornell.edu>
Date: Tue, 03 Jan 2006 13:04:23 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policycoreutils latest diffs.
References: <43BAC4EA.8020106@redhat.com>
In-Reply-To: <43BAC4EA.8020106@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> -			rc = commands.getstatusoutput("grep -v '^ *#' %s" % self.selinuxdir+self.type+"/seusers")
> -			if rc[0] == 0 and rc[1] != "":
> -				ulist = rc[1].split("\n")
> -				for u in ulist:
> -					if len(u)==0:
> +			try:
> +				fd =open(self.selinuxdir+self.type+"/seusers")
> +				for u in  fd.read().split('\n'):
> +					u=u.strip()
> +					if len(u)==0 or u[0]=="#":
>  						continue
>  					user = u.split(":")
>  					if len(user) < 3:
>  						continue
>   
Somebody pointed out that len(user) < 3 assumes the mls component of the 
seusers file is required.
This is not consistent with libsemanage and libselinux, which consider 
it optional.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
