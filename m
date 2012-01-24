Subject: Re: How I download SEandroid?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?=C1lvaro?= Castillo <midgoon@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CAHodhts2rLr=kc_ZLNQVgrN4CVNu=abQr1os53nP+=+Enj8kzA@mail.gmail.com>
References: 
	 <CAHodhts2rLr=kc_ZLNQVgrN4CVNu=abQr1os53nP+=+Enj8kzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Jan 2012 07:57:59 -0500
Message-ID: <1327409879.6331.1.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-01-24 at 11:55 +0000, Álvaro Castillo wrote:
> Hello,
> 
> I had a problem to download SEAndroid.
> 
> http://pastie.org/3240061
> 
> or, I have wrong to downloaded it.

You didn't follow the instructions to download it.  First, download AOSP
in the usual way.  Then copy local_manifest.xml to your .repo
subdirectory and run repo sync again.  Example:

mkdir seandroid
cd seandroid
repo init -u https://android.googlesource.com/platform/manifest
wget http://selinuxproject.org/~seandroid/local_manifest.xml
mv local_manifest.xml .repo
repo sync


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
