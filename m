Message-ID: <435CF981.7040700@cornell.edu>
Date: Mon, 24 Oct 2005 11:10:57 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Resync to sepol changes
References: <435A8AE9.3020709@cornell.edu>
In-Reply-To: <435A8AE9.3020709@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> - change Stub status code of all print functions from STATUS_ERR to 
> STATUS_NODATA, so that the flat file parser will exit and not get 
> stuck in infinite loop recalling the stubs.
s/print/parse/ here

My file parser loop hands all control over record parsing to the parse() 
function, so it is dependent on it to tell it when the last record is 
parsed (by signaling STATUS_NODATA), so that's the loop I got rid of for 
stubs.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
